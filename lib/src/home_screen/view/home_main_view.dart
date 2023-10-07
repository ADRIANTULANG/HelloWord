import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teachlang/src/home_screen/view/home_view_spellingquestion.dart';
import 'package:teachlang/src/spellingquiz_screen/view/spellingquiz_view.dart';
import '../../../config/custom_icons.dart';
import '../../../config/textstyle.dart';
import '../../grammarquiz_screen/view/grammarquiz_view.dart';
import '../controller/home_controller.dart';
import '../widget/home_view_drawer.dart';
import 'home_view_grammarLeaderBoard.dart';
import 'home_view_grammarquestion.dart';
import 'home_view_spellingLeaderBoard.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        drawer: HomeScreenAppDrawer.showAppDrawer(controller: controller),
        body: SafeArea(
            child: Container(
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Welcome!",
                          style: Styles.header1,
                        ),
                        Builder(builder: (context) {
                          return InkWell(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                              FocusScope.of(context).unfocus();
                            },
                            child: Obx(
                              () => Container(
                                height: 7.h,
                                width: 11.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            controller.imageLink.value)),
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
                            ),
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => GrammarQuizView());
                      },
                      child: Container(
                        height: 20.h,
                        width: 42.w,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  spreadRadius: 3,
                                  offset: Offset(1, 2))
                            ]),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                CustomIcons.testquiz,
                                width: 10.w,
                                height: 10.h,
                              ),
                              Text(
                                "Grammar Quiz",
                                style: Styles.normalBold,
                              )
                            ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SpellingQuizView());
                      },
                      child: Container(
                        height: 20.h,
                        width: 42.w,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  spreadRadius: 3,
                                  offset: Offset(1, 2))
                            ]),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                CustomIcons.spelling,
                                width: 10.w,
                                height: 10.h,
                              ),
                              Text(
                                "Spelling Quiz",
                                style: Styles.normalBold,
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: SizedBox(
                  width: 100.w,
                  child: Text(
                    "Reviewer",
                    style: Styles.header2,
                  ),
                ),
              ),
              Container(
                height: 40.h,
                padding: EdgeInsets.only(bottom: 1.h),
                child: Obx(
                  () => CarouselSlider(
                    carouselController: controller.carouselController,
                    options: CarouselOptions(
                      autoPlay: false,
                      aspectRatio: 1.6,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        controller.current_index.value = index;
                      },
                    ),
                    items: List.generate(
                        controller.allQuestions.length,
                        (index) => controller.allQuestions[index]
                                .toJson()
                                .containsKey('sentence')
                            ? HomeGrammarQuestionView(
                                index: index,
                                grammarQuetion: controller.allQuestions[index],
                              )
                            : HomeSpellingQuestionView(
                                index: index,
                                spellingQuestion:
                                    controller.allQuestions[index],
                              )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: SizedBox(
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          "${controller.current_leaderboard_view.value} Quiz Scores",
                          style: Styles.header2,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.onchangedLeaderboardView();
                        },
                        child: SvgPicture.asset(
                          CustomIcons.switchingview,
                          color: Colors.black,
                          width: 3.w,
                          height: 3.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Container(
                  child: Obx(() =>
                      controller.current_leaderboard_view.value == "Spelling"
                          ? HomeViewSpellingLeaderBoardView()
                          : HomeViewGrammarLeaderBoardView()),
                ),
              )
            ]),
          ),
        )),
      ),
    );
  }
}
