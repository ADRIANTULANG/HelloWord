// To parse this JSON data, do
//
//     final spellingScore = spellingScoreFromJson(jsonString);

import 'dart:convert';

List<SpellingScore> spellingScoreFromJson(String str) =>
    List<SpellingScore>.from(
        json.decode(str).map((x) => SpellingScore.fromJson(x)));

String spellingScoreToJson(List<SpellingScore> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpellingScore {
  int score;
  User user;

  SpellingScore({
    required this.score,
    required this.user,
  });

  factory SpellingScore.fromJson(Map<String, dynamic> json) => SpellingScore(
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
