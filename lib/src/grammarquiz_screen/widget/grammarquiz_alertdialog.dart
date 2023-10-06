import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/src/grammarquiz_screen/controller/grammarquiz_controller.dart';
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

  static showMessageAttemptToBack(
      {required GrammarQuizController controller}) async {
    Get.dialog(
      AlertDialog(
        key: controller.alertDialogKey,
        content: Container(
          height: 23.h,
          width: 100.w,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                width: 100.w,
                child: Text(
                  "Message",
                  style: Styles.header2,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                width: 100.w,
                child: Text(
                  "Quiting the quiz will submit your current output. are you sure you want to quit the quiz?",
                  style: Styles.normalFontSizeMedium,
                ),
              ),
              SizedBox(
                height: 3.5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("No", style: Styles.normalBold)),
                  TextButton(
                      onPressed: () {
                        Get.back();
                        controller.countDownTimer!.cancel();
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
