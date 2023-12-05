import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/config/custom_icons.dart';
import 'package:teachlang/config/textstyle.dart';

import '../controller/adminhome_controller.dart';

class AdminHomeGrammarCreateItem extends GetView<AdminHomeController> {
  const AdminHomeGrammarCreateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          child: SingleChildScrollView(
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
                  height: 18.h,
                  width: 100.w,
                  child: TextField(
                    controller: controller.grammarItemText,
                    maxLines: 15,
                    decoration: InputDecoration(
                      fillColor: Colors.lightBlue[50],
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 3.w, top: 2.h),
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
                      "Options",
                      style: Styles.boldFontSizeMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: SizedBox(
                    height: 7.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 6.h,
                          width: 70.w,
                          child: TextField(
                            controller: controller.optionText,
                            decoration: InputDecoration(
                              fillColor: Colors.lightBlue[50],
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                left: 3.w,
                              ),
                              alignLabelWithHint: false,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.optionsList.length < 4) {
                              controller.optionsList
                                  .add(controller.optionText.text);
                              controller.optionText.clear();
                            } else {
                              Get.snackbar("Message",
                                  "You can put 4 options. More than four is not allowed.",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            }
                          },
                          child: Container(
                              height: 6.h,
                              width: 15.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(Icons.add)),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: SizedBox(
                    height: 7.h,
                    width: 100.w,
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.optionsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: InkWell(
                              onTap: () {
                                controller.optionsList.removeAt(index);
                              },
                              child: Chip(
                                backgroundColor: Colors.lightBlue[100],
                                avatar: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.clear),
                                ),
                                label: Text(controller.optionsList[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                  child: SizedBox(
                    width: 100.w,
                    child: Text(
                      "Answer",
                      style: Styles.boldFontSizeMedium,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  height: 6.h,
                  width: 100.w,
                  child: TextField(
                    controller: controller.answerText,
                    decoration: InputDecoration(
                      fillColor: Colors.lightBlue[50],
                      filled: true,
                      contentPadding: EdgeInsets.only(
                        left: 3.w,
                      ),
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
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                  child: SizedBox(
                    width: 100.w,
                    child: Text(
                      "Type",
                      style: Styles.boldFontSizeMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                  child: Container(
                    height: 6.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Obx(
                      () => DropdownButton<String>(
                        value: controller.selectedCategory.value,
                        isExpanded: true,
                        elevation: 16,
                        underline: const SizedBox(),
                        padding: EdgeInsets.only(left: 2.w),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          controller.selectedCategory.value = value!;
                        },
                        items: controller.catList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  height: 10.h,
                  width: 100.w,
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () async {
                        if (controller.optionsList.length < 2) {
                          Get.snackbar("Message", "Invalid number of options.",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        } else if (controller.grammarItemText.text.isEmpty ||
                            controller.grammarItemText.text == "") {
                          Get.snackbar("Message", "Please put item",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        } else if (controller.groupValueDifficulty.value ==
                            "") {
                          Get.snackbar(
                              "Message", "Please select level of difficulty",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        } else if (controller.groupValueLanguage.value == "") {
                          Get.snackbar("Message", "Please select language.",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        } else {
                          controller.grammarSaveItem();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
