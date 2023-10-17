import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/config/custom_icons.dart';
import 'package:teachlang/config/textstyle.dart';

import '../controller/adminhome_controller.dart';

class AdminHomeSpellingCreateItem extends GetView<AdminHomeController> {
  const AdminHomeSpellingCreateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                child: SizedBox(
                  width: 100.w,
                  child: Text(
                    "Create Item",
                    style: Styles.header1,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                child: SizedBox(
                  width: 100.w,
                  child: Text(
                    "Item",
                    style: Styles.boldFontSizeMedium,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                height: 7.h,
                width: 100.w,
                child: TextField(
                  controller: controller.spellingItemText,
                  decoration: InputDecoration(
                    fillColor: Colors.lightBlue[50],
                    filled: true,
                    contentPadding: EdgeInsets.only(left: 3.w),
                    alignLabelWithHint: false,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                child: SizedBox(
                  width: 100.w,
                  child: Text(
                    "Language",
                    style: Styles.boldFontSizeMedium,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Row(
                  children: [
                    Obx(
                      () => Radio(
                          value: "English",
                          groupValue: controller.groupValueLanguage.value,
                          onChanged: (value) {
                            controller.groupValueLanguage.value =
                                value.toString();
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
                            controller.groupValueLanguage.value =
                                value.toString();
                          }),
                    ),
                    Text(
                      "Tagalog",
                      style: Styles.normal,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                child: SizedBox(
                  width: 100.w,
                  child: Text(
                    "Difficulty",
                    style: Styles.boldFontSizeMedium,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Row(
                  children: [
                    Obx(
                      () => Radio(
                          value: "Easy",
                          groupValue: controller.groupValueDifficulty.value,
                          onChanged: (value) {
                            controller.groupValueDifficulty.value =
                                value.toString();
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
                            controller.groupValueDifficulty.value =
                                value.toString();
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
                            controller.groupValueDifficulty.value =
                                value.toString();
                          }),
                    ),
                    Text(
                      "Hard",
                      style: Styles.normal,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 10.h,
        width: 100.w,
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () async {
              if (controller.spellingItemText.text.isEmpty ||
                  controller.spellingItemText.text == "") {
                Get.snackbar("Message", "Please put item",
                    backgroundColor: Colors.red, colorText: Colors.white);
              } else if (controller.groupValueDifficulty.value == "") {
                Get.snackbar("Message", "Please select level of difficulty",
                    backgroundColor: Colors.red, colorText: Colors.white);
              } else if (controller.groupValueLanguage.value == "") {
                Get.snackbar("Message", "Please select language.",
                    backgroundColor: Colors.red, colorText: Colors.white);
              } else {
                controller.spellingSaveItem();
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
                      CustomIcons.clickbutton,
                      color: Colors.lightBlue,
                      width: 5.w,
                      height: 5.h,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      "Click here to save",
                      style: Styles.normalBold,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
