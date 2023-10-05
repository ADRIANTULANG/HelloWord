import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../config/textstyle.dart';

class GrammarQuizAlertDialog {
  static showMessage({required String score, required String over}) async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 10.h,
      width: 100.w,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text("Your score is: $score/$over", style: Styles.normalBold),
    )));
  }
}
