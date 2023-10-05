import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/config/textstyle.dart';
import 'package:teachlang/src/spellingquiz_screen/controller/spellingquiz_controller.dart';

import '../../../config/custom_icons.dart';

class SpellingQuizTakingQuiz extends GetView<SpellingQuizController> {
  const SpellingQuizTakingQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
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
        Container(
          height: 60.h,
          padding: EdgeInsets.only(bottom: 1.h),
          child: CarouselSlider(
            carouselController: controller.carouselController,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                controller.current_index.value = index;
                controller.textInputedController.text =
                    controller.spellings[index].inputedWord.value;
              },
              autoPlay: false,
              aspectRatio: .9,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
            ),
            items: controller.spellings
                .map((item) => Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.lightBlue[100],
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
                                  controller.speak(word: item.word);
                                },
                                child: SvgPicture.asset(
                                  CustomIcons.personspeaking,
                                  color: Colors.white,
                                  width: 10.w,
                                  height: 10.h,
                                ),
                              ),
                            ),
                          )),
                          Container(
                            padding: EdgeInsets.only(left: 2.w, right: 2.w),
                            height: 7.h,
                            width: 100.w,
                            child: TextField(
                              controller: controller.textInputedController,
                              onChanged: (value) {
                                controller
                                    .spellings[controller.current_index.value]
                                    .inputedWord
                                    .value = value.toString();
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
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                controller.carouselController.previousPage();
              },
              child: Container(
                height: 7.h,
                width: 15.w,
                alignment: Alignment.center,
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
                child: Icon(Icons.arrow_back_ios_new),
              ),
            ),
            Obx(
              () => Text((controller.current_index.value + 1).toString() +
                  " / " +
                  controller.spellings.length.toString()),
            ),
            InkWell(
              onTap: () {
                controller.carouselController.nextPage();
              },
              child: Container(
                height: 7.h,
                width: 15.w,
                alignment: Alignment.center,
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
                child: Icon(Icons.arrow_forward_ios),
              ),
            )
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: InkWell(
            onTap: () {
              // controller.submitAnswer();
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
        ),
      ]),
    );
  }
}
