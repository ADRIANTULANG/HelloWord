// To parse this JSON data, do
//
//     final spellingsModel = spellingsModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<SpellingsModel> spellingsModelFromJson(String str) =>
    List<SpellingsModel>.from(
        json.decode(str).map((x) => SpellingsModel.fromJson(x)));

String spellingsModelToJson(List<SpellingsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpellingsModel {
  bool isActive;
  String word;
  String documentId;
  String difficulty;
  String language;
  RxString inputedWord;

  SpellingsModel({
    required this.isActive,
    required this.word,
    required this.documentId,
    required this.inputedWord,
    required this.difficulty,
    required this.language,
  });

  factory SpellingsModel.fromJson(Map<String, dynamic> json) => SpellingsModel(
        isActive: json["isActive"],
        word: json["word"],
        documentId: json["documentID"],
        difficulty: json["difficulty"],
        language: json["language"],
        inputedWord: "".obs,
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "inputedWord": inputedWord,
        "difficulty": difficulty,
        "language": language,
        "word": word,
        "documentID": documentId,
      };
}
