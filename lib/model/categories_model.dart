// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(String str) =>
    List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  DateTime dateTime;
  String name;
  String id;

  Categories({
    required this.dateTime,
    required this.name,
    required this.id,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        dateTime: DateTime.parse(json["dateTime"]),
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime.toIso8601String(),
        "name": name,
        "id": id,
      };
}
