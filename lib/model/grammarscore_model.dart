// To parse this JSON data, do
//
//     final grammarScore = grammarScoreFromJson(jsonString);

import 'dart:convert';

List<GrammarScore> grammarScoreFromJson(String str) => List<GrammarScore>.from(
    json.decode(str).map((x) => GrammarScore.fromJson(x)));

String grammarScoreToJson(List<GrammarScore> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GrammarScore {
  int score;
  User user;

  GrammarScore({
    required this.score,
    required this.user,
  });

  factory GrammarScore.fromJson(Map<String, dynamic> json) => GrammarScore(
        score: json["score"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "user": user.toJson(),
      };
}

class User {
  String firstname;
  String provider;
  bool isVerified;
  String imageUrl;
  String fcmToken;
  String userid;
  String email;
  String lastname;
  String contactno;

  User({
    required this.firstname,
    required this.provider,
    required this.isVerified,
    required this.imageUrl,
    required this.fcmToken,
    required this.userid,
    required this.email,
    required this.lastname,
    required this.contactno,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstname: json["firstname"],
        provider: json["provider"],
        isVerified: json["isVerified"],
        imageUrl: json["imageUrl"],
        fcmToken: json["fcmToken"],
        userid: json["userid"],
        email: json["email"],
        lastname: json["lastname"],
        contactno: json["contactno"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "provider": provider,
        "isVerified": isVerified,
        "imageUrl": imageUrl,
        "fcmToken": fcmToken,
        "userid": userid,
        "email": email,
        "lastname": lastname,
        "contactno": contactno,
      };
}
