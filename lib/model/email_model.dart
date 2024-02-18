// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Email {
  Email({
    this.id,
    required this.address,
    required this.name,
    required this.phone,
    required this.message,
    this.created_at,
  });

  factory Email.fromMap(Map<String, dynamic> map) {
    return Email(
      id: map['id']?.toString() ?? "0",
      address: map['address']?.toString() ?? "",
      name: map['name']?.toString() ?? "",
      phone: map['phone']?.toString() ?? "",
      message: map['message']?.toString() ?? "",
      created_at: map['created_at'] != null ? DateTime.tryParse(map['created_at']) ?? DateTime.now() : DateTime.now(),
    );
  }

  factory Email.fromJson(String source) => Email.fromMap(json.decode(source) as Map<String, dynamic>);

  final String? id;
  final String address;
  final String name;
  final String? phone;
  final String message;
  final DateTime? created_at;

  Map<String, dynamic> nameMap() {
    return <String, dynamic>{
      'id': uuid.v4(),
      'address': address,
      'name': name,
      'phone': phone,
      'message': message,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  String nameJson() => json.encode(nameMap());
}
