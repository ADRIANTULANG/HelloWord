import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiver/async.dart';
import 'package:teachlang/model/grammar_model.dart';
import 'package:teachlang/src/home_screen/controller/home_controller.dart';

import '../../../model/categories_model.dart';
import '../widget/grammarquiz_alertdialog.dart';

class GrammarQuizController extends GetxController {
  CountdownTimer? countDownTimer;
  RxBool isSubmitting = false.obs;
  RxBool isTaking = false.obs;
  RxInt current = 180.obs;
  RxInt start = 180.obs;
  RxString remainingTime = '00 : 00'.obs;
  final GlobalKey alertDialogKey = GlobalKey();
  RxList<GrammarModel> grammarList = <GrammarModel>[].obs;
  RxString groupValueLanguage = ''.obs;
  RxString groupValueDifficulty = ''.obs;
  RxList<Categories> categoriesList = <Categories>[].obs;
  RxList<String> catList = <String>[].obs;
  RxString selectedCategory = ''.obs;

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }

  startTimer() async {
    countDownTimer = CountdownTimer(
      Duration(seconds: start.value),
      const Duration(seconds: 1),
    );
    var sub = countDownTimer!.listen(null);
    sub.onData((duration) {
      current.value = start.value - duration.elapsed.inSeconds;
      remainingTime.value = formattedTime(timeInSecond: current.value);
    });
    sub.onDone(() {
      sub.cancel();
      submitAnswer();
    });
  }

  Future<bool> checkIfThereIsOpenDialog() async {
    if (alertDialogKey.currentContext != null) {
      return true;
    } else {
      return false;
    }
  }

  getBack({required GrammarQuizController controller}) async {
    if (isTaking.value == true) {
      // print("user did start the quiz and wants to navigate back");
      GrammarQuizAlertDialog.showMessageAttemptToBack(controller: controller);
    } else {
      // print("user did not start the quiz");
      Get.back();
    }
  }

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  getGrammarsQuestions(
      {required String difficulty, required String language}) async {
    List data = [];

    var res = await FirebaseFirestore.instance
        .collection('grammar')
        .where('isActive', isEqualTo: true)
        .where("category", isEqualTo: selectedCategory.value)
        .where('difficulty', isEqualTo: groupValueDifficulty.value)
        .where('language', isEqualTo: groupValueLanguage.value)
        .get();
    var grammarResults = res.docs;
    for (var i = 0; i < grammarResults.length; i++) {
      Map mapdata = grammarResults[i].data();
      mapdata['documentID'] = grammarResults[i].id;
      mapdata.remove('dateCreate');
      data.add(mapdata);
    }
    grammarList.assignAll(grammarModelFromJson(jsonEncode(data)));
  }

  submitAnswer() async {
    isSubmitting(true);
    int correctAnswer = 0;
    for (var i = 0; i < grammarList.length; i++) {
      if (grammarList[i].answer == grammarList[i].selectedAnswer.value) {
        correctAnswer = correctAnswer + 1;
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
    if (userres.docs.isNotEmpty) {
      var userDocumentReference = FirebaseFirestore.instance
          .collection('users')
          .doc(userres.docs[0].id);
      var isUserExist = await FirebaseFirestore.instance
          .collection('grammarscore')
          .where('user', isEqualTo: userDocumentReference)
          .where('difficulty', isEqualTo: groupValueDifficulty.value)
          .where('language', isEqualTo: groupValueLanguage.value)
          .get();
      // check if user has already score record in the spelling collection
      if (isUserExist.docs.isNotEmpty) {
        // update the answer of the user.
        await FirebaseFirestore.instance
            .collection('grammarscore')
            .doc(isUserExist.docs[0].id)
            .update({"score": correctAnswer});
      } else {
        var userDocumentReference = FirebaseFirestore.instance
            .collection('users')
            .doc(userres.docs[0].id);
        await FirebaseFirestore.instance.collection('grammarscore').add({
          "user": userDocumentReference,
          "score": correctAnswer,
          "difficulty": groupValueDifficulty.value,
          "language": groupValueLanguage.value,
        });
      }
    }
    isSubmitting(false);
    isTaking(false);
    remainingTime.value = '00 : 00';
    current.value = 180;
    start.value = 180;
    if (await checkIfThereIsOpenDialog() == true) {
      Get.back();
    }
    GrammarQuizAlertDialog.showMessage(
        score: correctAnswer.toString(), over: grammarList.length.toString());
    Get.find<HomeController>().getScores();
  }

  getAllCategories() async {
    try {
      var res = await FirebaseFirestore.instance.collection("category").get();
      var categories = res.docs;
      List list = [];
      catList.clear();
      catList.add('');
      for (var i = 0; i < categories.length; i++) {
        Map data = categories[i].data();
        data['id'] = categories[i].id;
        data['dateTime'] = data['dateTime'].toDate().toString();
        list.add(data);
        catList.add(data['name']);
      }
      categoriesList.assignAll(categoriesFromJson(jsonEncode(list)));
    } catch (_) {}
  }

  // populateGrammar() async {
  //   WriteBatch batch = FirebaseFirestore.instance.batch();
  //   for (var i = 0; i < listofgrammar.length; i++) {
  //     batch.set(await FirebaseFirestore.instance.collection('grammar').doc(), {
  //       "answer": listofgrammar[i]['answer'],
  //       "options": listofgrammar[i]['options'],
  //       "sentence": listofgrammar[i]['sentence'],
  //       "isActive": true,
  //     });
  //   }
  //   await batch.commit();
  // }
}
