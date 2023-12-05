// To parse this JSON data, do
//
//     final grammarModel = grammarModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<GrammarModel> grammarModelFromJson(String str) => List<GrammarModel>.from(
    json.decode(str).map((x) => GrammarModel.fromJson(x)));

String grammarModelToJson(List<GrammarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GrammarModel {
  String sentence;
  String answer;
  List<String> options;
  bool isActive;
  String documentId;
  String category;
  String difficulty;
  String language;
  RxString selectedAnswer;

  GrammarModel({
    required this.sentence,
    required this.answer,
    required this.options,
    required this.isActive,
    required this.documentId,
    required this.difficulty,
    required this.language,
    required this.selectedAnswer,
    required this.category,
  });

  factory GrammarModel.fromJson(Map<String, dynamic> json) => GrammarModel(
        sentence: json["sentence"],
        answer: json["answer"],
        category: json["category"],
        options: List<String>.from(json["options"].map((x) => x)),
        isActive: json["isActive"],
        documentId: json["documentID"],
        difficulty: json["difficulty"],
        language: json["language"],
        selectedAnswer: "".obs,
      );

  Map<String, dynamic> toJson() => {
        "sentence": sentence,
        "answer": answer,
        "difficulty": difficulty,
        "language": language,
        "category": category,
        "selectedAnswer": selectedAnswer,
        "options": List<dynamic>.from(options.map((x) => x)),
        "isActive": isActive,
        "documentID": documentId,
      };
}
