import 'dart:convert';
import 'package:cupidknot/models/registration_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

final String baseUrl = 'https://cupidknot.kuldip.dev/api';

// class ActionServices {
//   Dio dio = new Dio();
//   register(first_name,last_name,email,password,password_confirmation,birth_date,gender) async{
    
//   }
// }


// class ApiManager {
//   void getData() async {
//     var client = http.Client();
//     var response = await client.get(Uri.parse(baseUrl));
//     if (response.statusCode == 200) {
//       var jsonString = response.body;
//       var jsonMap = json.decode(jsonString);
//     }
//   }
// }
