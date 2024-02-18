// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Rating {
  Rating({
    this.id,
    required this.title,
    required this.rate,
    required this.comment,
    required this.validated,
    required this.deleted,
    this.created_at,
  });

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      id: map['id']?.toString() ?? "0",
      title: map['title']?.toString() ?? "",
      rate: int.tryParse(map['rate']?.toString() ?? '3') ?? 3,
      comment: map['comment']?.toString() ?? "",
      validated: map['validated'] ?? false,
      deleted: map['deleted'] ?? false,
      created_at: map['created_at'] != null ? DateTime.tryParse(map['created_at']) ?? DateTime.now() : DateTime.now(),
    );
  }

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source) as Map<String, dynamic>);

  final String? id;
  final String? title;
  final int? rate;
  final String? comment;
  final bool validated;
  final bool deleted;
  final DateTime? created_at;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': uuid.v4(),
      'title': title,
      'rate': rate,
      'comment': comment,
      'validated': validated,
      'deleted': deleted,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
