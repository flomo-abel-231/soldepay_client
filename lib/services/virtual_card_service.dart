import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:soldepay/models/card_balance.dart';
import 'package:soldepay/models/card_transaction.dart';

class VirtualCardService {
  final storage = const FlutterSecureStorage();

  // Update this depending on your environment:
  // For Android emulator: use 10.0.2.2 instead of 127.0.0.1
  // For physical device: use your computer's LAN IP (e.g., 192.168.x.x)
  final String baseUrl = 'https://soldepay-app.onrender.com/api';

  Future<String> getToken() async {
    final rawToken = await storage.read(key: 'token') ?? '';
    final cleaned = rawToken.replaceAll(RegExp(r'\s+'), '');

    print('Raw token: $rawToken');
    print('Cleaned token: $cleaned');

    return cleaned;
  }

  Future<http.Response> createCustomer() async {
    final token = await getToken();
    var url = Uri.parse("$baseUrl/virtual-card/create-customer");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode({}));

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Customer created successfully or already exists
      return response;
    } else if (response.statusCode == 500 &&
        response.body.contains("Customer already exist")) {
      // You may want to treat this as a "success" if your logic allows
      return response;
    } else {
      throw Exception("Failed creating card customer: ${response.body}");
    }
  }

  Future<http.Response> createCard(Map<String, dynamic> cardData) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/virtual-card/create-card'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(cardData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception("Card creation failed: ${response.body}");
    }
  }

  Future<http.Response> mtnMoMoTopUpPayment(
      Map<String, dynamic> topUpData) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/momo/checkRequestToPayStatusAndFundCard"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode(topUpData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception("Error paying with MTN Mobile Money. Ensure the amount is"
          " not less than 10.00 USD or more than 250.00 USD. "
          "Also check the phone number is valid or registered MTN Mobile Money Number. ");
    }
  }

  Future<CardBalance> fetchCardBalance() async {
    final token = await getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/virtual-card/get-card-balance'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return CardBalance.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch balance: ${response.body}');
    }
  }

  Future<String?> getCardId() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/virtual-card/get-card-id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final String resId = response.body;
      return resId;
    } else {
      print('Failed to get card ID: ${response.body}');
      return null;
    }
  }

  Future<String?> getCardToken() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/virtual-card/get-card-token'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final String resToken = response.body;
      return resToken;
    } else {
      print('Failed to get card token: ${response.body}');
      return null;
    }
  }

  Future<List<CardTransaction>> fetchCardTransactions() async {
    final token = await getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/virtual-card/get-transaction'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => CardTransaction.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch transactions: ${response.body}");
    }
  }

  Future<bool> checkUserHasCard() async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/virtual-card/check-user-has-card'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        bool hasCard = json['hasCard'] == true;
        print("User has card? $hasCard");
        return hasCard;
      } else {
        print(
            "Failed to check card. Status code: ${response.statusCode}, Body: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error checking card status: $e");
      return false;
    }
  }
}
