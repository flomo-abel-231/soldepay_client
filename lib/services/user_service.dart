import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:soldepay/models/document_request.dart';
import 'package:soldepay/models/login_request.dart';
import 'package:soldepay/models/otp_request.dart';

import '../models/user.dart';

class UserService {
  // avd local host 10.0.2.2
  final String baseUrl = "https://soldepay-app.onrender.com/api";
  final storage = FlutterSecureStorage();

  Future<http.Response> registerUser(User user) async {
    // create uri
    var url = Uri.parse("$baseUrl/users/register");
    //
    Map<String, String> headers = {"Content-Type": "application/json"};

    Map data = {
      "email": user.email,
      "password": user.password,
      "firstName": user.firstName,
      "lastName": user.lastName,
      "phoneNumber": user.phoneNumber,
      "countryCode": user.countryCode,
      "address": user.address,
      "city": user.city,
      "country": user.country,
      "postalCode": user.postalCode,
      "dateOfBirth": user.dateOfBirth.toString(),
      "state": user.state,
      "govtIdNumber": user.govtIdNumber,
      "title": user.title,
      "gender": user.gender
    };

    var body = json.encode(data);
    var response = await http.post(url, headers: headers, body: body);

    return response;
  }

  Future<http.Response> loginWithOtp(LoginRequest loginRequest) async {
    var url = Uri.parse('$baseUrl/users/login-with-otp');
    Map<String, String> headers = {"Content-Type": "application/json"};

    Map data = {
      "identifier": loginRequest.identifier,
      "password": loginRequest.password,
      "otp": loginRequest.otp
    };

    var body = json.encode(data);

    var response = await http.post(url, headers: headers, body: body);

    print('Login response body: ${response.body}');

    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    String tokenOnly = jsonData["token"] ?? "";

    tokenOnly = tokenOnly.replaceAll('"', '').trim();

    print('Token after cleanup: "$tokenOnly"');

    if (response.statusCode == 200 && tokenOnly.isNotEmpty) {
      await storage.write(key: "token", value: tokenOnly);
    }

    return response;
  }

  Future<http.Response> generateOtp(OtpRequest otpRequest) async {
    var url = Uri.parse('$baseUrl/users/generate-otp');
    Map data = {"identifier": otpRequest.identifier};

    var body = jsonEncode(data);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response = await http.post(url, headers: headers, body: body);

    return response;
  }

  Future<http.Response> updateUser(User user, int id) async {
    var url = Uri.parse('$baseUrl/users/update?id=$id');

    Map<String, String> headers = {"Content-Type": "application/json"};

    Map data = {};

    var body = jsonEncode(data);

    var response = await http.post(url, headers: headers, body: body);

    return response;
  }

  Future<http.Response> uploadDocument(DocumentRequest documentRequest) async {
    var token = await storage.read(key: "token");

    var url = Uri.parse("$baseUrl/document/upload");

    var request = http.MultipartRequest("POST", url)
      ..headers["Authorization"] = "Bearer $token";

    request.files.add(await http.MultipartFile.fromPath(
      'passportPic',
      documentRequest.passportSizePhoto,
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'frontId',
      documentRequest.passportOrGovernmentIdFront,
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'backId',
      documentRequest.passportOrGovernmentIdBack,
    ));

    // Send the request
    final streamedResponse = await request.send();

    // Convert to http.Response for easier handling
    final response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  Future<void> logout() async {
    final token = await storage.read(key: "token") ?? "";
    final url = Uri.parse('$baseUrl/users/logout');
    final response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200) {
      await storage.delete(key: "token");
    } else {
      throw Exception("Logout failed: ${response.body}");
    }
  }

  Future<User?> findUserByEmail(String email) async {
    final url = Uri.parse('$baseUrl/findUserByEmail?email=$email');
    final response = await http.get(url);
    if (response.statusCode == 200 && response.body != "null") {
      return User.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<bool> checkPhoneExist(String phone) async {
    final url = Uri.parse('$baseUrl/checkPhoneExist?phoneNumber=$phone');
    final response = await http.get(url);
    return response.body != "null";
  }

  Future<String> deleteUser() async {
    final token = await storage.read(key: "token");
    final url = Uri.parse('$baseUrl/delete-user');
    final response = await http.delete(url, headers: {
      "Authorization": "Bearer $token",
    });
    return response.body;
  }
}
