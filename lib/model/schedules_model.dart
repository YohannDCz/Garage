import 'dart:convert';

class SchedulesModel {
  SchedulesModel({
    this.id,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory SchedulesModel.fromMap(Map<String, dynamic> map) {
    return SchedulesModel(
      id: map['id']?.toString() ?? "0",
      monday: map['monday']?.toString() ?? "",
      tuesday: map['tuesday']?.toString() ?? "",
      wednesday: map['wednesday']?.toString() ?? "",
      thursday: map['thursday']?.toString() ?? "",
      friday: map['friday']?.toString() ?? "",
      saturday: map['saturday']?.toString() ?? "",
      sunday: map['sunday']?.toString() ?? "",
    );
  }

  factory SchedulesModel.fromJson(String source) => SchedulesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final String? id;
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
    };
  }

  String toJson() => json.encode(toMap());
}
