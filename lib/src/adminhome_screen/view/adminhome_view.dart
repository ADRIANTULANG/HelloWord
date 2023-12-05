import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/config/custom_icons.dart';
import 'package:teachlang/src/adminhome_screen/view/adminhome_spelling_listview.dart';

import '../../../config/textstyle.dart';
import '../controller/adminhome_controller.dart';
import 'admin_home_category_list.dart';
import 'adminhome_grammar_listview.dart';

class AdmiHomeView extends GetView<AdminHomeController> {
  const AdmiHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminHomeController());
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        SizedBox(
          height: 1.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Welcome!",
                style: Styles.header1,
              ),
              SvgPicture.asset(
                CustomIcons.logout,
                color: Colors.black,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: InkWell(
            onTap: () {
              Get.to(() => const HomeAdminGrammarListView());
            },
            child: Container(
              height: 20.h,
              width: 100.w,
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
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
                      "Grammar Quiz Items",
                      style: Styles.normalBold,
                    )
                  ]),
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: InkWell(
            onTap: () {
              Get.to(() => const HomeAdminSpellingListView());
            },
            child: Container(
              height: 20.h,
              width: 100.w,
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
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
                      "Spelling Quiz Items",
                      style: Styles.normalBold,
                    )
                  ]),
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: InkWell(
            onTap: () {
              Get.to(() => const AdminCategoryView());
              // controller.updateDate();
            },
            child: Container(
              height: 20.h,
              width: 100.w,
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
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
                      CustomIcons.cat,
                      width: 10.w,
                      height: 10.h,
                    ),
                    Text(
                      "Category",
                      style: Styles.normalBold,
                    )
                  ]),
            ),
          ),
        ),
      ])),
    );
  }
}
