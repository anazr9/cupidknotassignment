import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  String? first_name;
  String? last_name;
  String? email;
  String? password;
  String? password_confirmation;
  String? birth_date;
  String? gender;
  Register(
      {this.first_name,
      this.last_name,
      this.email,
      this.password,
      this.password_confirmation,
      this.birth_date,
      this.gender});
  factory Register.fromJson(Map<String, dynamic> json) => Register(
      first_name: json["first_name"],
      last_name: json["last_name"],
      email: json["email"],
      password: json["password"],
      password_confirmation: json["password_confirmation"],
      birth_date: json["birth_date"],
      gender: json["gender"]);
  Map<String, dynamic> toJson() => {
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
        "password": password,
        "password_confirmation": password_confirmation,
        "birth_date": birth_date,
        "gender": gender
      };
}
