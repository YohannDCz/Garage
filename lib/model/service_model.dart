// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

class Service {
  Service({
    required this.id,
    required this.category,
    required this.label,
    required this.description,
    required this.image,
    required this.created_at,
  });

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id']?.toString() ?? "0",
      category: map['category']?.toString() ?? "",
      label: map['label']?.toString() ?? "",
      description: map['description']?.toString() ?? "",
      image: map['image']?.toString() ?? "",
      created_at: map['created_at'] != null ? DateTime.tryParse(map['created_at']) : DateTime.now(),
    );
  }

  factory Service.fromJson(String source) => Service.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;
  final String category;
  final String label;
  final String description;
  final String image;
  final DateTime? created_at;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'label': label,
      'description': description,
      'image': image,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
