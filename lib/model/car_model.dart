// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Car {
  Car({
    this.id,
    required this.model,
    required this.price,
    required this.year,
    required this.type,
    required this.kilometers,
    required this.image,
    this.created_at,
    this.equipments,
  });

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id']?.toString() ?? "0",
      model: map['model']?.toString() ?? "",
      price: int.tryParse(map['price']?.toString() ?? '100') ?? 100,
      year: int.tryParse(map['year']?.toString() ?? '2000') ?? 2000,
      type: map['type']?.toString() ?? "",
      kilometers: int.tryParse(map['kilometers']?.toString() ?? '10000') ?? 10000,
      image: map['image']?.toString() ?? "",
      created_at: map['created_at'] != null ? DateTime.tryParse(map['created_at']) ?? DateTime.now() : DateTime.now(),
      equipments: map['equipments'] != null ? map['equipments'].replaceAll(RegExp(r'[\[\]"]'), '').split(',') : [],
    );
  }

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source) as Map<String, dynamic>);

  final String? id;
  final String? model;
  final int price;
  final int year;
  final String? type;
  final int kilometers;
  final String? image;
  final DateTime? created_at;
  final List<String>? equipments;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': uuid.v4(),
      'model': model,
      'price': price,
      'year': year,
      'type': type,
      'kilometers': kilometers,
      'image': image,
      'created_at': DateTime.now().toIso8601String(),
      'equipments': equipments,
    };
  }

  String toJson() => json.encode(toMap());
}
