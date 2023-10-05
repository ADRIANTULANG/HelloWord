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
  RxString selectedAnswer;

  GrammarModel({
    required this.sentence,
    required this.answer,
    required this.options,
    required this.isActive,
    required this.documentId,
    required this.selectedAnswer,
  });

  factory GrammarModel.fromJson(Map<String, dynamic> json) => GrammarModel(
        sentence: json["sentence"],
        answer: json["answer"],
        options: List<String>.from(json["options"].map((x) => x)),
        isActive: json["isActive"],
        documentId: json["documentID"],
        selectedAnswer: "".obs,
      );

  Map<String, dynamic> toJson() => {
        "sentence": sentence,
        "answer": answer,
        "selectedAnswer": selectedAnswer,
        "options": List<dynamic>.from(options.map((x) => x)),
        "isActive": isActive,
        "documentID": documentId,
      };
}
