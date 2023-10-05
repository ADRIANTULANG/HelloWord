import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../model/grammar_model.dart';
import '../../../model/grammarscore_model.dart';
import '../../../model/spelling_model.dart';
import '../../../model/spellingscroe_model.dart';
import '../../login_screen/view/login_view.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    await getGrammarsQuestions();
    await getSpellings();
    combineQuestios();
    getScores();
    super.onInit();
  }

  RxInt current_index = 0.obs;
  CarouselController carouselController = CarouselController();
  FlutterTts flutterTts = FlutterTts();
  TextEditingController textInputedController = TextEditingController();
  RxList<GrammarModel> grammarList = <GrammarModel>[].obs;
  RxList<SpellingsModel> spellings = <SpellingsModel>[].obs;
  RxList allQuestions = [].obs;
  RxList<GrammarScore> grammarScoreList = <GrammarScore>[].obs;
  RxList<SpellingScore> spellingsScoreList = <SpellingScore>[].obs;
  RxString current_leaderboard_view = 'Grammar'.obs;

  RxString imageLink =
      'https://firebasestorage.googleapis.com/v0/b/teachlanguage-cbeb0.appspot.com/o/profilenew.jpg?alt=media&token=e1b2e99f-faa7-494c-9b50-44a9434fa525&_gl=1*1a54zm7*_ga*MTgxNTgwMjk1OS4xNjk2MzA5NDc2*_ga_CW55HF8NVT*MTY5NjQ5ODQ3Ny4xMy4xLjE2OTY0OTkwODguNDEuMC4w'
          .obs;

  logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Get.offAll(() => LoginView());
  }

  getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var userres = await FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: user!.uid)
        .limit(1)
        .get();
    if (userres.docs.length > 0) {
      var userInfo = userres.docs[0].data();
      if (userInfo['imageUrl'] != '') {
        imageLink.value = userInfo['imageUrl'];
      }
    } else {}
  }

  getGrammarsQuestions() async {
    List data = [];
    var res = await FirebaseFirestore.instance
        .collection('grammar')
        .where('isActive', isEqualTo: true)
        .get();
    var grammarResults = res.docs;
    for (var i = 0; i < grammarResults.length; i++) {
      Map mapdata = grammarResults[i].data();
      mapdata['documentID'] = grammarResults[i].id;
      data.add(mapdata);
    }
    grammarList.assignAll(await grammarModelFromJson(jsonEncode(data)));
  }

  getSpellings() async {
    var res = await FirebaseFirestore.instance
        .collection('spellings')
        .where('isActive', isEqualTo: true)
        .get();
    var spellingsResult = res.docs;
    List data = [];
    for (var i = 0; i < spellingsResult.length; i++) {
      Map mapData = spellingsResult[i].data();
      mapData['documentID'] = spellingsResult[i].id;
      data.add(mapData);
    }
    spellings.assignAll(await spellingsModelFromJson(jsonEncode(data)));
  }

  getScores() async {
    List datagrammar = [];
    List dataspelling = [];
    try {
      var resgrammar = await FirebaseFirestore.instance
          .collection('grammarscore')
          .orderBy('score', descending: true)
          .get();
      var grammarScoreResult = resgrammar.docs;
      for (var i = 0; i < grammarScoreResult.length; i++) {
        Map mapGrammar = grammarScoreResult[i].data();
        var userMap = await grammarScoreResult[i]['user'].get();
        mapGrammar['user'] = userMap.data();
        datagrammar.add(mapGrammar);
      }
      grammarScoreList
          .assignAll(await grammarScoreFromJson(jsonEncode(datagrammar)));
    } on Exception catch (e) {
      print("ERROR $e");
    }
    var resspelling = await FirebaseFirestore.instance
        .collection('spellingscore')
        .orderBy('score', descending: true)
        .get();
    var spellingScoreResult = resspelling.docs;
    for (var i = 0; i < spellingScoreResult.length; i++) {
      Map mapSpelling = spellingScoreResult[i].data();
      var userMap = await spellingScoreResult[i]['user'].get();
      mapSpelling['user'] = userMap.data();
      dataspelling.add(mapSpelling);
    }
    spellingsScoreList
        .assignAll(await spellingScoreFromJson(jsonEncode(dataspelling)));
  }

  combineQuestios() async {
    allQuestions.addAll(grammarList);
    allQuestions.addAll(spellings);
    allQuestions.shuffle();
  }

  Future speak({required String word}) async {
    var result = await flutterTts.speak(word);
    if (result == 1) {}
  }

  onClickAnswerForGrammar({required GrammarModel grammar}) async {
    if (grammar.answer == grammar.selectedAnswer.value) {
      Get.snackbar("Message", "Your answer is correct",
          colorText: Colors.white, backgroundColor: Colors.greenAccent);
    } else {
      Get.snackbar("Message", "Your answer is wrong",
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  onClickAnswerForSpelling({required SpellingsModel spelling}) async {
    if (spelling.word.toLowerCase().trim().toString() ==
        spelling.inputedWord.toLowerCase().trim().toString()) {
      Get.snackbar("Message", "Your answer is correct",
          colorText: Colors.white, backgroundColor: Colors.greenAccent);
    } else {
      Get.snackbar("Message", "Your answer is wrong",
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  onchangedLeaderboardView() {
    if (current_leaderboard_view.value == "Grammar") {
      current_leaderboard_view.value = "Spelling";
    } else {
      current_leaderboard_view.value = "Grammar";
    }
    print(current_leaderboard_view.value);
  }
}
