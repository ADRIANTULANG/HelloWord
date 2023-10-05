import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:quiver/async.dart';

import '../../../model/spelling_model.dart';
import '../../home_screen/controller/home_controller.dart';
import '../widget/spellingquiz_alertdialog.dart';

class SpellingQuizController extends GetxController {
  FlutterTts flutterTts = FlutterTts();
  RxBool isTaking = false.obs;
  RxInt current = 180.obs;
  RxInt start = 180.obs;
  RxString remainingTime = '00 : 00'.obs;
  RxInt current_index = 0.obs;
  RxList<SpellingsModel> spellings = <SpellingsModel>[].obs;
  CountdownTimer? countDownTimer;
  CarouselController carouselController = CarouselController();
  TextEditingController textInputedController = TextEditingController();
  RxBool isSubmitting = false.obs;
  @override
  void onReady() {
    getSpellings();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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

  // populateSpellings() async {
  //   WriteBatch batch = FirebaseFirestore.instance.batch();
  //   for (var i = 0; i < liststrings.length; i++) {
  //     batch.set(await FirebaseFirestore.instance.collection('spellings').doc(),
  //         {"isActive": true, "word": liststrings[i]});
  //   }
  //   await batch.commit();
  // }

  startTimer() async {
    countDownTimer = await CountdownTimer(
      Duration(seconds: start.value),
      Duration(seconds: 1),
    );
    var sub = countDownTimer!.listen(null);
    sub.onData((duration) {
      current.value = start.value - duration.elapsed.inSeconds;
      remainingTime.value = formattedTime(timeInSecond: current.value);
    });
    sub.onDone(() {
      print("Done");
      sub.cancel();
      submitAnswer();
    });
  }

  Future speak({required String word}) async {
    var result = await flutterTts.speak(word);
    if (result == 1) {}
  }

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  submitAnswer() async {
    isSubmitting(true);
    int correct_answer = 0;
    for (var i = 0; i < spellings.length; i++) {
      if (spellings[i].word.toLowerCase().trim().toString() ==
          spellings[i].inputedWord.toLowerCase().trim().toString()) {
        correct_answer = correct_answer + 1;
      }
    }
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var userres = await FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: user!.uid)
        .limit(1)
        .get();
    // check if user exist in the users collection to get userDocumentReference
    if (userres.docs.length > 0) {
      var userDocumentReference = await FirebaseFirestore.instance
          .collection('users')
          .doc(userres.docs[0].id);
      var isUserExist = await FirebaseFirestore.instance
          .collection('spellingscore')
          .where('user', isEqualTo: userDocumentReference)
          .get();
      // check if user has already score record in the spelling collection
      if (isUserExist.docs.length == 0) {
        var userDocumentReference = await FirebaseFirestore.instance
            .collection('users')
            .doc(userres.docs[0].id);
        await FirebaseFirestore.instance
            .collection('spellingscore')
            .add({"user": userDocumentReference, "score": correct_answer});
      } else {
        // update the answer of the user.
        await FirebaseFirestore.instance
            .collection('spellingscore')
            .doc(isUserExist.docs[0].id)
            .update({"score": correct_answer});
      }
    }
    isSubmitting(false);
    isTaking(false);
    remainingTime.value = '00 : 00';
    current.value = 180;
    start.value = 180;
    SpellingQuizAlertDialog.showMessage(
        score: correct_answer.toString(), over: spellings.length.toString());
    Get.find<HomeController>().getScores();
  }
}
