import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/config/textstyle.dart';
import 'package:teachlang/src/adminhome_screen/view/adminhome_spelling_createitem.dart';
import 'package:teachlang/src/adminhome_screen/view/adminhome_spelling_updateitem.dart';
import 'package:teachlang/src/adminhome_screen/widget/adminhome_alertdialog.dart';

import '../controller/adminhome_controller.dart';

class HomeAdminSpellingListView extends GetView<AdminHomeController> {
  const HomeAdminSpellingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Spelling Quiz Items",
                    style: Styles.header1,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w,
                ),
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.spellingList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          "${(index + 1).toString()}.",
                                          style: Styles.boldFontSizeMedium,
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          controller.spellingList[index].word,
                                          style: Styles.normalFontSizeMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          AdminHomeAlertDialog.showDeleteItem(
                                              controller: controller,
                                              type: "Spellings",
                                              documentID: controller
                                                  .spellingList[index]
                                                  .documentId);
                                        },
                                        child: Container(
                                            height: 6.h,
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.redAccent,
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: const Icon(Icons.delete)),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              AdminHomeSpellingUpdateItem(
                                                  documentID: controller
                                                      .spellingList[index]
                                                      .documentId,
                                                  word: controller
                                                      .spellingList[index].word,
                                                  difficultyGroupValue:
                                                      controller
                                                          .spellingList[index]
                                                          .difficulty,
                                                  languageGroupValue: controller
                                                      .spellingList[index]
                                                      .language));
                                        },
                                        child: Container(
                                            height: 6.h,
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.lightBlue[100],
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: const Icon(Icons.edit)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Difficulty: ",
                                    style: Styles.normalFontSizeMedium,
                                  ),
                                  Text(
                                    controller.spellingList[index].difficulty,
                                    style: Styles.boldFontSizeMedium,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Language: ",
                                    style: Styles.normalFontSizeMedium,
                                  ),
                                  Text(
                                    controller.spellingList[index].language,
                                    style: Styles.boldFontSizeMedium,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              const Divider()
                            ],
                          ));
                    },
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          Get.to(() => const AdminHomeSpellingCreateItem());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
