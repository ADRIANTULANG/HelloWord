import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/textstyle.dart';
import '../controller/home_controller.dart';

class HomeViewGrammarLeaderBoardView extends GetView<HomeController> {
  const HomeViewGrammarLeaderBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.grammarScoreList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      (index + 1).toString(),
                      style: Styles.normalBold,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Container(
                      height: 7.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: controller.grammarScoreList[index].user
                                          .imageUrl ==
                                      ''
                                  ? NetworkImage(controller.imageLink.value)
                                  : NetworkImage(controller
                                      .grammarScoreList[index].user.imageUrl)),
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
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      controller.grammarScoreList[index].user.firstname == "" &&
                              controller
                                      .grammarScoreList[index].user.lastname ==
                                  ""
                          ? controller.grammarScoreList[index].user.email
                          : controller.grammarScoreList[index].user.firstname +
                              " " +
                              controller.grammarScoreList[index].user.lastname,
                      style: Styles.normal,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 1.h, bottom: 1.h, left: 2.w, right: 2.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.blue[100]),
                  child: Text(
                    controller.grammarScoreList[index].score.toString(),
                    style: Styles.normal,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
