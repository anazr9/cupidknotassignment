import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:cupidknot/models/users_model.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  List<UserImage>? images;
  String? firstName;
  String? lastName;

  String? email;
  String? religion;
  String? gender;
  String? birthDate;
  UserDetailScreen(
      {Key? key,
      required this.images,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.religion,
      required this.gender,
      required this.birthDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images == null) {
      print('null');
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('User Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(firstName == null
                  ? 'Not Provided'
                  : 'First Name: ' + firstName!),
              Text(lastName == null
                  ? 'Not Provided'
                  : 'Last Name: ' + lastName!),
              Text(email == null ? 'Not Provided' : 'Email: ' + email!),
              Text(
                  religion == null ? 'Not Provided' : 'Religion: ' + religion!),
              Text(gender == null ? 'Not Provided' : 'Gender: ' + gender!),
              Text(birthDate == null
                  ? 'Not Provided'
                  : 'Date of birth: ' + birthDate!),
              SizedBox(
                height: 12,
              ),
              Text(
                'User Images',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: images!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return images == null
                          ? Text('Images Not Provided')
                          : Image.network(
                              images![index].path! + images![index].name!,
                              width: MediaQuery.of(context).size.width,
                            );
                      // Text('eee');
                    }),
              ),
            ],
          ),
        ));
  }
}
