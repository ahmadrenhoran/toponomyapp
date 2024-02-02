import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toponomy_app/model/user.dart';

class AuthController with ChangeNotifier {
  // final String baseUrl = "http://localhost:5207/api";

  final String baseUrl = "http://127.0.0.1:5207/api";

  // final String baseUrl = "http://10.0.2.2:5027/api";

  Future<bool> registerUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': 0,
        'username': user.username,
        'email': user.email,
        'password': user.password
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // Proses login berhasil
      saveUserDataLocally(user);
      return true;
    } else {
      // throw Exception('Failed to login');
      return false;
    }
  }

  void saveUserDataLocally(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', user.id);
    prefs.setString('username', user.username);
    prefs.setString('email', user.email);
    prefs.setBool('isLoggedIn', true);
    // Add more data as needed
  }

  Future<User?> getUserLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');

    if (userId != null && username != null && email != null) {
      return User(id: userId, username: username, email: email, password: "");
    } else {
      return null;
    }
  }
}
