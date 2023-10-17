import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../config/textstyle.dart';
import '../controller/grammarquiz_controller.dart';
import 'grammarquiz_introduction.dart';
import 'grammarquiz_takingtest.dart';

class GrammarQuizView extends GetView<GrammarQuizController> {
  const GrammarQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GrammarQuizController());
    return WillPopScope(
      onWillPop: () => controller.getBack(controller: controller),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Obx(
            () => controller.isSubmitting.value == true
                ? SizedBox(
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
                              "Grammar Quiz",
                              style: Styles.header1,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Obx(
                            () => controller.isTaking.value == false
                                ? const GrammarQuizIntroductionView()
                                : const GrammarQuizTakingTest(),
                          ),
                        ]),
                  ),
          ),
        ),
      ),
    );
  }
}
