// lib/Auth/RegisterAuthProvider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Auth/userModel.dart';

class RegisterAuthProvider with ChangeNotifier {
  Future<void> register(User user) async {
    final url = Uri.parse('http://192.168.1.140/api/Authenticate/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200) {
        print('Login Successfull.');
      } else {
        // Handle error
        throw Exception('Failed to register');
      }
    } catch (error) {
      throw error;
    }
  }
}
