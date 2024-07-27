// lib/LoginAuthProvider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAuthProvider with ChangeNotifier {
  Future<void> login(String username, String password) async {
    final url = Uri.parse('https://e941-202-47-48-55.ngrok-free.app/api/Authenticate/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token']; // Get token from response
        final role = responseData['role'];   // Get role from response

        // Save token and role in local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('auth_role', role);

        print('Login Successful.');
      } else {
        // Handle error
        throw Exception('Failed to login');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout(BuildContext context) async {
    // Perform any local logout actions here (clear session, tokens, etc.)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('auth_role');

    // Navigate to the login screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<void> getTokenAndRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    String? role = prefs.getString('auth_role');

    if (token != null) {
      print('Token: $token');
    } else {
      print('No token found');
    }

    if (role != null) {
      print('Role: $role');
    } else {
      print('No role found');
    }
  }
}
