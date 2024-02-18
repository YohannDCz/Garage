// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class AppUser {
  AppUser({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class CustomUser {
  CustomUser({
    required this.name,
    required this.birthdate,
    required this.email,
    required this.type,
    required this.created_at,
    required this.password,
  });

  factory CustomUser.fromMap(Map<String, dynamic> map) {
    return CustomUser(
      name: map["first_name"] != null ? map['first_name'] as String : "",
      birthdate: map["birthday_date"] != null ? DateTime.parse(map['birthday_date']) : null,
      email: map['email'] != null ? map['email'] as String : "",
      type: map['type'] != null ? map['type'] as String : "",
      created_at: map["created_at"] != null ? DateTime.parse(map['created_at']) : null,
      password: "Le mot de passe est en SHA256",
    );
  }

  factory CustomUser.fromJson(String source) => CustomUser.fromMap(json.decode(source) as Map<String, dynamic>);
  final String name;
  final DateTime? birthdate;
  final DateTime? created_at;
  final String email;
  final String type;
  final String password;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': Supabase.instance.client.auth.currentUser!.id,
      'name': name,
      'birthday_date': birthdate?.toUtc().toIso8601String(),
      'created_at': DateTime.now(),
      'email': email,
      'type': 'employe',
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}
