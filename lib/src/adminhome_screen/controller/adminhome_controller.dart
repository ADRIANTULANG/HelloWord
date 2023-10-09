import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teachlang/model/spelling_model.dart';

import '../../../model/grammar_model.dart';

class AdminHomeController extends GetxController {
  @override
  void onInit() {
    getGrammarItems();
    getSpellingItems();
    super.onInit();
  }

  RxList<String> optionsList = <String>[].obs;

  RxList<GrammarModel> grammarList = <GrammarModel>[].obs;
  RxList<SpellingsModel> spellingList = <SpellingsModel>[].obs;

  TextEditingController optionText = TextEditingController();
  TextEditingController grammar_itemText = TextEditingController();
  TextEditingController answerText = TextEditingController();

  TextEditingController spelling_itemText = TextEditingController();

  RxString groupValueLanguage = ''.obs;
  RxString groupValueDifficulty = ''.obs;

  getGrammarItems() async {
    List data = [];
    var res = await FirebaseFirestore.instance
        .collection('grammar')
        .orderBy('dateCreate', descending: true)
        .get();
    var grammar = res.docs;
    for (var i = 0; i < grammar.length; i++) {
      Map mapdata = grammar[i].data();
      mapdata['documentID'] = grammar[i].id;
      mapdata.remove('dateCreate');
      data.add(mapdata);
    }
    grammarList.assignAll(await grammarModelFromJson(jsonEncode(data)));
  }

  getSpellingItems() async {
    List data = [];
    var res = await FirebaseFirestore.instance
        .collection('spellings')
        .orderBy('dateCreate', descending: true)
        .get();
    var spelling = res.docs;
    for (var i = 0; i < spelling.length; i++) {
      Map mapdata = spelling[i].data();
      mapdata['documentID'] = spelling[i].id;
      mapdata.remove('dateCreate');
      data.add(mapdata);
    }
    spellingList.assignAll(await spellingsModelFromJson(jsonEncode(data)));
  }

  grammar_saveItem() async {
    try {
      await FirebaseFirestore.instance.collection('grammar').add({
        "answer": answerText.text,
        "difficulty": groupValueDifficulty.value,
        "isActive": true,
        "language": groupValueLanguage.value,
        "options": optionsList,
        "sentence": grammar_itemText.text,
        "dateCreate": Timestamp.now()
      });
      answerText.clear();
      optionsList.clear();
      groupValueDifficulty.value = '';
      groupValueLanguage.value = '';
      grammar_itemText.clear();
      Get.snackbar("Message", "Item added",
          backgroundColor: Colors.green, colorText: Colors.white);
      getGrammarItems();
    } catch (e) {
      print(e);
    }
  }

  grammar_updateItem({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('grammar')
          .doc(documentID)
          .update({
        "answer": answerText.text,
        "difficulty": groupValueDifficulty.value,
        "isActive": true,
        "language": groupValueLanguage.value,
        "options": optionsList,
        "sentence": grammar_itemText.text,
      });
      getGrammarItems();
      Get.back();
      answerText.clear();
      optionsList.clear();
      groupValueDifficulty.value = '';
      groupValueLanguage.value = '';
      grammar_itemText.clear();
      Get.snackbar("Message", "Item updated",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      print(e);
    }
  }

  grammar_deleteItem({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('grammar')
          .doc(documentID)
          .delete();
      getGrammarItems();
      Get.back();
      Get.snackbar("Message", "Item deleted",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      print(e);
    }
  }

  spelling_saveItem() async {
    try {
      await FirebaseFirestore.instance.collection('spellings').add({
        "dateCreate": Timestamp.now(),
        "difficulty": groupValueDifficulty.value,
        "isActive": true,
        "language": groupValueLanguage.value,
        "word": spelling_itemText.text,
      });

      groupValueDifficulty.value = '';
      groupValueLanguage.value = '';
      spelling_itemText.clear();
      Get.snackbar("Message", "Item added",
          backgroundColor: Colors.green, colorText: Colors.white);
      getSpellingItems();
    } catch (e) {
      print(e);
    }
  }

  spelling_updateItem({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('spellings')
          .doc(documentID)
          .update({
        "difficulty": groupValueDifficulty.value,
        "language": groupValueLanguage.value,
        "word": spelling_itemText.text,
      });
      Get.back();
      groupValueDifficulty.value = '';
      groupValueLanguage.value = '';
      spelling_itemText.clear();
      Get.snackbar("Message", "Item updated",
          backgroundColor: Colors.green, colorText: Colors.white);
      getSpellingItems();
    } catch (e) {
      print(e);
    }
  }

  spelling_deleteItem({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('spellings')
          .doc(documentID)
          .delete();
      getSpellingItems();
      Get.back();
      Get.snackbar("Message", "Item deleted",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      print(e);
    }
  }

  // updateDate() async {
  //   var res = await FirebaseFirestore.instance.collection('spellings').get();
  //   var spellings = res.docs;
  //   WriteBatch batch = FirebaseFirestore.instance.batch();
  //   for (var i = 0; i < spellings.length; i++) {
  //     var documentRef = await FirebaseFirestore.instance
  //         .collection('spellings')
  //         .doc(spellings[i].id);
  //     batch.update(documentRef, {"dateCreate": Timestamp.now()});
  //   }
  //   await batch.commit();
  // }
}
