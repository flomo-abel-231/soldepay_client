import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soldepay/services/virtual_card_service.dart';

import '../../routes/app_routes.dart';

class MomoPayScreen extends StatefulWidget {
  const MomoPayScreen({super.key});

  @override
  State<MomoPayScreen> createState() => _MomoPayScreenState();
}

class _MomoPayScreenState extends State<MomoPayScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final VirtualCardService virtualCardService = VirtualCardService();

  bool isProcessing = false;
  Timer? _pollingTimer;
  final int _pollIntervalSeconds = 5;
  final int _timeoutMinutes = 10;

  Future<void> handleMomoPayment() async {
    final phone = phoneController.text.trim();
    final amountText = amountController.text.trim();

    if (phone.isEmpty || amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter phone and amount")),
      );
      return;
    }

    setState(() => isProcessing = true);
    final amount = double.parse(amountText);

    try {
      final topUpData = {"payerNumber": phone, "amount": amount};

      // Start initial payment request
      await virtualCardService.mtnMoMoTopUpPayment(topUpData);

      // Start polling for status
      final startTime = DateTime.now();
      _pollingTimer = Timer.periodic(
        Duration(seconds: _pollIntervalSeconds),
        (timer) async {
          final elapsed = DateTime.now().difference(startTime);
          if (elapsed.inMinutes >= _timeoutMinutes) {
            timer.cancel();
            showReceipt(
              amount: amount,
              status: "TIMEOUT",
              transactionId: "N/A",
              currency: "USD",
            );
            return;
          }

          try {
            final statusResponse =
                await virtualCardService.mtnMoMoTopUpPayment(topUpData);
            final data = jsonDecode(statusResponse.body);

            String status = data["status"] ?? "UNKNOWN";
            String transactionId =
                data["financialTransactionId"] ?? data["externalId"] ?? "N/A";
            String currency = data["currency"] ?? "USD";

            if (status == "SUCCESSFUL" || status == "FAILED") {
              timer.cancel();
              showReceipt(
                  amount: amount,
                  status: status,
                  transactionId: transactionId,
                  currency: currency);
            }
          } catch (e) {
            // Ignore polling errors
            print("Polling error: $e");
          }
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error initiating MoMo payment: $e")),
      );
      setState(() => isProcessing = false);
    }
  }

  void showReceipt({
    required double amount,
    required String status,
    required String transactionId,
    required String currency,
  }) {
    final fee = amount * 0.03;
    final netAmount = amount - fee;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment Receipt"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status: $status"),
            const SizedBox(height: 8),
            Text("Transaction ID: $transactionId"),
            const SizedBox(height: 8),
            Text("Amount Paid: $currency ${amount.toStringAsFixed(2)}"),
            const SizedBox(height: 8),
            Text("Fee (3%): $currency ${fee.toStringAsFixed(2)}"),
            const SizedBox(height: 8),
            Text("Net Amount: $currency ${netAmount.toStringAsFixed(2)}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacementNamed(context, AppRoutes.home_screen);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    ).then((_) {
      setState(() => isProcessing = false);
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MTN MoMo Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "MTN MoMo Number"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isProcessing ? null : handleMomoPayment,
              child: Text(isProcessing ? "Processing..." : "Pay with MoMo"),
            ),
            const SizedBox(height: 16),
            const Text(
              "ℹ️ After pressing pay, please check your MTN MoMo SMS and approve it within 10 minutes.",
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
