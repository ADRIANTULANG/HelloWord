import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/src/home_screen/controller/home_controller.dart';

import '../../../config/custom_icons.dart';
import '../../../model/spelling_model.dart';

class HomeSpellingQuestionView extends GetView<HomeController> {
  const HomeSpellingQuestionView(
      {super.key, required this.spellingQuestion, required this.index});
  final SpellingsModel spellingQuestion;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h, bottom: 2.h),
      decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(1, 2))
          ]),
      child: Column(
        children: [
          Expanded(
              child: SizedBox(
            child: Center(
              child: InkWell(
                onTap: () {
                  controller.speak(word: spellingQuestion.word);
                },
                child: SvgPicture.asset(
                  CustomIcons.personspeaking,
                  color: Colors.black,
                  width: 10.w,
                  height: 10.h,
                ),
              ),
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 7.h,
                width: 55.w,
                child: TextField(
                  onChanged: (value) {
                    spellingQuestion.inputedWord.value = value.toString();
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.lightBlue[50],
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 3.w),
                      alignLabelWithHint: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2)),
                      hintText: 'Answer'),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.onClickAnswerForSpelling(
                      spelling: spellingQuestion);
                },
                child: Container(
                  height: 7.h,
                  width: 11.w,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            spreadRadius: 3,
                            offset: Offset(1, 2))
                      ],
                      border: Border.all(width: 2),
                      shape: BoxShape.circle,
                      color: Colors.lightBlue),
                  child: Icon(Icons.check),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
