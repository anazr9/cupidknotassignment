import 'dart:convert';
import 'package:cupidknot/constants/constants.dart';
import 'package:cupidknot/models/registration_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'login_screen.dart';

Future<Register?> registrationData(
    String? first_name,
    String? last_name,
    String? email,
    String? password,
    String? password_confirmation,
    String? birth_date,
    String? gender) async {
  final String apiUrl = 'https://cupidknot.kuldip.dev/api/register';
  final response = await http.post(Uri.parse(apiUrl), body: {
    "first_name": first_name,
    "last_name": last_name,
    "email": email,
    "password": password,
    "password_confirmation": password_confirmation,
    "birth_date": birth_date,
    "gender": gender
  });
  if (response.statusCode == 200) {
    final String accessToken = jsonDecode(response.body)["access_token"];

    print(accessToken);
  } else {
    final String responseString = response.body;
    print(responseString);
  }
}

Future<String> tokenData() async {
  final String apiUrl = 'https://cupidknot.kuldip.dev/api/register';
  final response = await http.post(Uri.parse(apiUrl),
      body: {"username": username, "password": password});
  if (response.statusCode == 200) {
    final String accessToken = jsonDecode(response.body)["access_token"];

    return accessToken;
  } else {
    throw ({});
  }
}

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? firstName;
    String? secondName;
    String? email;
    String? password;
    String? confirm_password;
    String? date_of_birth;
    String? gender;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('First Name'),
                TextFormField(
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    firstName = value;
                  },
                ),
                Text('Last Name'),
                TextFormField(
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    secondName = value;
                  },
                ),
                Text('email'),
                TextFormField(
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                Text('password'),
                TextFormField(
                  decoration: kTextFieldDecoration,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                Text('Password Confirmation'),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Minimum Lenght 8'),
                  obscureText: true,
                  onChanged: (value) {
                    confirm_password = value;
                  },
                ),
                Text('Date Of Birth'),
                TextFormField(
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Ex: 2000-10-10'),
                  onChanged: (value) {
                    date_of_birth = value;
                  },
                ),
                Text('Gender'),
                TextFormField(
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    gender = value;
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Already registered? Login here',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  onTap: () async {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
                TextButton(
                    onPressed: () async {
                      final Register? register = await registrationData(
                          firstName,
                          secondName,
                          email,
                          password,
                          confirm_password,
                          date_of_birth,
                          gender);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
