import 'package:flutter/material.dart';
import 'package:soldepay/models/card_transaction.dart';
import 'package:soldepay/services/virtual_card_service.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late Future<List<CardTransaction>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = VirtualCardService().fetchCardTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History"),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<CardTransaction>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No transactions found."));
          }

          final transactions = snapshot.data!;

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tx = transactions[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: ListTile(
                  title: Text("Type: ${tx.type}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Amount: \$${tx.amount}"),
                      Text("Status: ${tx.status}"),
                      Text("Date: ${tx.createdAt}"),
                    ],
                  ),
                  leading: Icon(Icons.account_balance_wallet_rounded,
                      color: tx.status.toLowerCase() == 'success'
                          ? Colors.green
                          : Colors.orange),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
