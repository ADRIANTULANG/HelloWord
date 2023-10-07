import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/src/spellingquiz_screen/controller/spellingquiz_controller.dart';

import '../../../config/custom_icons.dart';
import '../../../config/textstyle.dart';

class SpellingQuizIntroductionView extends GetView<SpellingQuizController> {
  const SpellingQuizIntroductionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        "Welcome to Spelling Quiz. You have 2 minutes to take the spelling test. The test will automatically submit your output once the timer is up. If there is still time remaining, you can review your answers to ensure that everything is correct before submitting",
        style: Styles.normalFontSizeMedium,
      ),
      SizedBox(
        height: 3.h,
      ),
      SizedBox(
        width: 100.w,
        child: Text(
          "Please select language",
          style: Styles.normalBold,
        ),
      ),
      SizedBox(
        height: 1.h,
      ),
      Row(
        children: [
          Obx(
            () => Radio(
                value: "English",
                groupValue: controller.groupValueLanguage.value,
                onChanged: (value) {
                  controller.groupValueLanguage.value = value.toString();
                }),
          ),
          Text(
            "English",
            style: Styles.normal,
          ),
          SizedBox(
            width: 5.w,
          ),
          Obx(
            () => Radio(
                value: "Tagalog",
                groupValue: controller.groupValueLanguage.value,
                onChanged: (value) {
                  controller.groupValueLanguage.value = value.toString();
                }),
          ),
          Text(
            "Tagalog",
            style: Styles.normal,
          ),
        ],
      ),
      SizedBox(
        height: 3.h,
      ),
      SizedBox(
        width: 100.w,
        child: Text(
          "Please select difficulty",
          style: Styles.normalBold,
        ),
      ),
      SizedBox(
        height: 1.h,
      ),
      Row(
        children: [
          Obx(
            () => Radio(
                value: "Easy",
                groupValue: controller.groupValueDifficulty.value,
                onChanged: (value) {
                  controller.groupValueDifficulty.value = value.toString();
                }),
          ),
          Text(
            "Easy",
            style: Styles.normal,
          ),
          SizedBox(
            width: 5.w,
          ),
          Obx(
            () => Radio(
                value: "Medium",
                groupValue: controller.groupValueDifficulty.value,
                onChanged: (value) {
                  controller.groupValueDifficulty.value = value.toString();
                }),
          ),
          Text(
            "Medium",
            style: Styles.normal,
          ),
          SizedBox(
            width: 5.w,
          ),
          Obx(
            () => Radio(
                value: "Hard",
                groupValue: controller.groupValueDifficulty.value,
                onChanged: (value) {
                  controller.groupValueDifficulty.value = value.toString();
                }),
          ),
          Text(
            "Hard",
            style: Styles.normal,
          ),
        ],
      ),
      SizedBox(
        width: 100.w,
        height: 40.h,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () async {
              if (controller.groupValueDifficulty.value != "" &&
                  controller.groupValueLanguage.value != "") {
                await controller.getSpellings(
                    difficulty: controller.groupValueDifficulty.value,
                    language: controller.groupValueLanguage.value);
                controller.isTaking.value = true;
                controller.startTimer();
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 7.h,
              width: 100.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      CustomIcons.playquiz,
                      color: Colors.lightBlue,
                      width: 5.w,
                      height: 5.h,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      "Click here to start",
                      style: Styles.normalBold,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
