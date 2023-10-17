import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/src/home_screen/controller/home_controller.dart';

import '../../../config/textstyle.dart';
import '../../../model/grammar_model.dart';

class HomeGrammarQuestionView extends GetView<HomeController> {
  const HomeGrammarQuestionView(
      {super.key, required this.grammarQuetion, required this.index});
  final GrammarModel grammarQuetion;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h, bottom: 2.h),
      width: 100.w,
      decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(1, 2))
          ]),
      child: Obx(
        () => controller.currentIndex.value != index
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    grammarQuetion.sentence,
                    style: Styles.normal,
                  ),
                  SizedBox(
                    width: 100.w,
                    child: ListView.builder(
                      itemCount: grammarQuetion.options.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int optionindex) {
                        return Row(
                          children: [
                            SizedBox(
                              height: 5.h,
                              width: 5.h,
                              child: Obx(
                                () => Checkbox(
                                    value: grammarQuetion
                                                .selectedAnswer.value ==
                                            grammarQuetion.options[optionindex]
                                        ? true
                                        : false,
                                    onChanged: (value) {
                                      grammarQuetion.selectedAnswer.value =
                                          grammarQuetion.options[optionindex];
                                      controller.onClickAnswerForGrammar(
                                          grammar: grammarQuetion);
                                    }),
                              ),
                            ),
                            Text(
                              grammarQuetion.options[optionindex],
                              style: Styles.normal,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
