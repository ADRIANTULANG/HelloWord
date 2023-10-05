import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/src/spellingquiz_screen/view/spellingquiz_view_introduction.dart';
import 'package:teachlang/src/spellingquiz_screen/view/spellingquiz_view_takingtest.dart';
import '../../../config/textstyle.dart';
import '../controller/spellingquiz_controller.dart';

class SpellingQuizView extends GetView<SpellingQuizController> {
  const SpellingQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SpellingQuizController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Obx(
          () => controller.isSubmitting.value == true
              ? Container(
                  height: 100.h,
                  width: 100.w,
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Colors.lightBlue,
                      size: 50.sp,
                    ),
                  ),
                )
              : Container(
                  height: 100.h,
                  width: 100.w,
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        InkWell(
                          onTap: () {
                            // SpellingQuizAlertDialog.showMessage(
                            //     score: "16", over: 16.toString());
                          },
                          child: Text(
                            "Spelling Quiz",
                            style: Styles.header1,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Obx(
                          () => controller.isTaking.value == false
                              ? SpellingQuizIntroductionView()
                              : SpellingQuizTakingQuiz(),
                        ),
                      ]),
                ),
        ),
      ),
    );
  }
}
