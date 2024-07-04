import 'dart:convert';

import 'package:Adal/User/model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "https://d6ce-202-47-48-55.ngrok-free.app/api/Cases";

  Future<List<User>> getUserData() async {
    List<User> data = [];

    final uri = Uri.parse(baseUri);
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json) => User.fromJson(json)).toList();
      }
    } catch (e) {
      return data;
    }
    return data;
  }

  Future<http.Response> updateUser(
      {required int id, required User user}) async {
    final uri = Uri.parse("$baseUri/Update/$id");
    late http.Response response;

    try {
      response = await http.put(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user),
      );
    } catch (e) {
      return response;
    }

    return response;
  }

  Future<http.Response> addUser({required User user}) async {
    print("Kya error hy bhai?");
    final uri = Uri.parse("$baseUri/Add");
    // late http.Response response;
    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user),
      );
      print("Kya error h?");
      return response;
    } catch (e) {
      // Handle errors here, such as logging the error or throwing an exception
      print('Error adding user: $e');
      throw Exception('Failed to add user');
    }
  }

  Future<http.Response> deleteUser({required int id}) async {
    final uri = Uri.parse("$baseUri/Delete/$id");
    late http.Response response;

    try {
      response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      return response;
    }
    return response;
  }

  Future<User> getUserById({required int id}) async {
    final uri = Uri.parse("$baseUri/GetById/$id");
    User? user;
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        user = User.fromJson(jsonData);
      }
    } catch (e) {
      return user!;
    }
    return user!;
  }
}
