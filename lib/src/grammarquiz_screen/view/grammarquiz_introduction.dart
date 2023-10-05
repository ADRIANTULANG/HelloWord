import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/src/grammarquiz_screen/controller/grammarquiz_controller.dart';

import '../../../config/custom_icons.dart';
import '../../../config/textstyle.dart';

class GrammarQuizIntroductionView extends GetView<GrammarQuizController> {
  const GrammarQuizIntroductionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        "Welcome to Grammar Quiz. You have 2 minutes to take the grammar test. The test will automatically submit your output once the timer is up. If there is still time remaining, you can review your answers to ensure that everything is correct before submitting. Click the button bellow if you are ready.",
        style: Styles.normalFontSizeMedium,
      ),
      SizedBox(
        width: 100.w,
        height: 60.h,
        child: Center(
          child: InkWell(
            onTap: () {
              controller.isTaking.value = true;
              controller.startTimer();
            },
            child: SvgPicture.asset(
              CustomIcons.clickbutton,
              color: Colors.lightBlue,
              width: 10.w,
              height: 10.h,
            ),
          ),
        ),
      )
    ]);
  }
}
