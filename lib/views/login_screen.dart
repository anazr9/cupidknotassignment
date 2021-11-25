import 'dart:convert';

import 'package:cupidknot/constants/constants.dart';
import 'package:cupidknot/models/login_model.dart';
import 'package:cupidknot/views/error_screen.dart';
import 'package:cupidknot/views/list_user_screen.dart';
import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'package:http/http.dart' as http;

Future<Login?> loginData(String? username, String? password) async {
  final String apiUrl = 'https://cupidknot.kuldip.dev/api/login';
  final response = await http.post(Uri.parse(apiUrl),
      body: {"username": username, "password": password});
}

Future<String> tokenData() async {
  final String apiUrl = 'https://cupidknot.kuldip.dev/api/login';
  final response = await http.post(Uri.parse(apiUrl),
      body: {"username": username, "password": password});
  if (response.statusCode == 200) {
    final String accessToken = jsonDecode(response.body)["access_token"];

    return accessToken;
  } else if (response.statusCode == 400) {
    return 'null';
  }
  throw {ErrorScreen()};
}

String? username;
String? password;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter username'),
                TextFormField(
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    username = value;
                  },
                ),
                Text('Enter password'),
                TextFormField(
                  decoration: kTextFieldDecoration,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Text(
                      'New User? Register here',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen()));
                    },
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final Login? login = await loginData(username, password);
                    String accessToken = await tokenData();
                    // accessToken == 'null'
                    //     ? Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => ErrorScreen()))
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UsersScreen(accessToken: accessToken)));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
