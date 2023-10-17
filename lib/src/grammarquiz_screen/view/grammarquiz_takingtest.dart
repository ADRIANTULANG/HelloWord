import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/src/grammarquiz_screen/controller/grammarquiz_controller.dart';

import '../../../config/textstyle.dart';

class GrammarQuizTakingTest extends GetView<GrammarQuizController> {
  const GrammarQuizTakingTest({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
              width: 100.w,
              child: Row(
                children: [
                  Text(
                    "Remaining time - ",
                    style: Styles.normalBold,
                  ),
                  Obx(() => Text(controller.remainingTime.value.toString())),
                ],
              )),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            width: 100.w,
            height: 72.h,
            child: ListView.builder(
              itemCount: controller.grammarList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${(index + 1).toString()}. ${controller.grammarList[index].sentence}",
                        style: Styles.normalFontSizeMedium,
                      ),
                      SizedBox(
                        width: 100.w,
                        child: ListView.builder(
                          itemCount:
                              controller.grammarList[index].options.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int optionindex) {
                            return Row(
                              children: [
                                Obx(
                                  () => Checkbox(
                                      value: controller.grammarList[index]
                                                  .selectedAnswer.value ==
                                              controller.grammarList[index]
                                                  .options[optionindex]
                                          ? true
                                          : false,
                                      onChanged: (value) {
                                        controller.grammarList[index]
                                                .selectedAnswer.value =
                                            controller.grammarList[index]
                                                .options[optionindex];
                                      }),
                                ),
                                Text(
                                  controller
                                      .grammarList[index].options[optionindex],
                                  style: Styles.normalFontSizeMedium,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          InkWell(
            onTap: () {
              controller.countDownTimer!.cancel();
            },
            child: Container(
              height: 7.h,
              width: 100.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "Submit",
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
