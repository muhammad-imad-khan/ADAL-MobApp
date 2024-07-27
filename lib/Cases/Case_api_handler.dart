import 'dart:convert';
import 'package:Adal/Cases/CaseModel.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "https://e941-202-47-48-55.ngrok-free.app";

 Future<List<Cases>> getCasesData() async {
  List<Cases> data = [];

  final uri = Uri.parse("$baseUri/api/Cases/AllCaseList");
  try {
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final responseBody = json.decode(response.body);
      final List<dynamic> jsonData = responseBody['data']; // Extract 'data' field
      print(jsonData);
      data = jsonData.map((json) => Cases.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Cases data');
    }
  } catch (e) {
    print('Error fetching Cases: $e');
    throw Exception('Error fetching Cases: $e');
  }
  return data;
}


  Future<List<Cases>> getClientCasesData() async {
  List<Cases> data = [];

  final uri = Uri.parse("$baseUri/api/Cases/AllCaseList");
  try {
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final responseBody = json.decode(response.body);
      final List<dynamic> jsonData = responseBody['data']; // Extract 'data' field
      print(jsonData);
      data = jsonData.map((json) => Cases.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Cases data');
    }
  } catch (e) {
    print('Error fetching Cases: $e');
    throw Exception('Error fetching Cases: $e');
  }
  return data;
}


 Future<List<Cases>> getLawyerCasesData() async {
  List<Cases> data = [];

  final uri = Uri.parse("$baseUri/api/Cases/GetCaseLawyer");
  try {
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final responseBody = json.decode(response.body);
      final List<dynamic> jsonData = responseBody['data']; // Extract 'data' field
      print(jsonData);
      data = jsonData.map((json) => Cases.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Cases data');
    }
  } catch (e) {
    print('Error fetching Cases: $e');
    throw Exception('Error fetching Cases: $e');
  }
  return data;
}


  Future<http.Response> updateCases({required int id, required Cases case_}) async {
    final uri = Uri.parse("$baseUri/Update/$id");
    late http.Response response;

    try {
      response = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(case_.toJson()),
      );
    } catch (e) {
      print('Error updating Cases: $e');
      throw Exception('Failed to update Cases');
    }

    return response;
  }

  Future<http.Response> addCases({required Cases case_}) async {
    final uri = Uri.parse("$baseUri/Add");
    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(case_.toJson()),
      );
      return response;
    } catch (e) {
      print('Error adding Cases: $e');
      throw Exception('Failed to add Cases');
    }
  }

  Future<http.Response> deleteCases({required int id}) async {
    final uri = Uri.parse("$baseUri/Delete/$id");
    late http.Response response;

    try {
      response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      print('Error deleting Cases: $e');
      throw Exception('Failed to delete Cases');
    }
    return response;
  }

  Future<Cases> getCasesById({required int id}) async {
    final uri = Uri.parse("$baseUri/GetById/$id");
    Cases? case_;

    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        case_ = Cases.fromJson(jsonData);
      }
    } catch (e) {
      print('Error fetching Cases by ID: $e');
      throw Exception('Failed to fetch Cases by ID');
    }
    return case_!;
  }
}
