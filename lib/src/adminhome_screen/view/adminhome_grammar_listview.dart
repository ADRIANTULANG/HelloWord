import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/config/textstyle.dart';
import 'package:teachlang/src/adminhome_screen/view/adminhome_grammar_updateitem.dart';
import 'package:teachlang/src/adminhome_screen/widget/adminhome_alertdialog.dart';
import '../controller/adminhome_controller.dart';
import 'adminhome_grammar_createitem.dart';

class HomeAdminGrammarListView extends GetView<AdminHomeController> {
  const HomeAdminGrammarListView({super.key});

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
                    "Grammar Quiz Items",
                    style: Styles.header1,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.grammarList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      "${(index + 1).toString()}.",
                                      style: Styles.boldFontSizeMedium,
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      child: Text(
                                        controller.grammarList[index].sentence,
                                        style: Styles.normalFontSizeMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              SizedBox(
                                width: 100.w,
                                child: ListView.builder(
                                  itemCount: controller
                                      .grammarList[index].options.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int optionindex) {
                                    return Text(
                                      "• ${controller.grammarList[index].options[optionindex]}",
                                      style: Styles.normalFontSizeMedium,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Answer: ",
                                    style: Styles.normalFontSizeMedium,
                                  ),
                                  Text(
                                    controller.grammarList[index].answer,
                                    style: Styles.boldFontSizeMedium,
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
                                    controller.grammarList[index].difficulty,
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
                                    controller.grammarList[index].language,
                                    style: Styles.boldFontSizeMedium,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      AdminHomeAlertDialog.showDeleteItem(
                                          type: "Grammar",
                                          controller: controller,
                                          documentID: controller
                                              .grammarList[index].documentId);
                                    },
                                    child: Container(
                                        height: 6.h,
                                        width: 20.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Icon(Icons.delete)),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => AdminHomeGrammarUpdateItem(
                                          documentID: controller
                                              .grammarList[index].documentId,
                                          listofoptions: controller
                                              .grammarList[index].options,
                                          difficultyGroupValue: controller
                                              .grammarList[index].difficulty,
                                          languageGroupValue: controller
                                              .grammarList[index].language,
                                          item: controller
                                              .grammarList[index].sentence,
                                          answer: controller
                                              .grammarList[index].answer));
                                    },
                                    child: Container(
                                        height: 6.h,
                                        width: 20.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.lightBlue[100],
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Icon(Icons.edit)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              const Divider()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          Get.to(() => const AdminHomeGrammarCreateItem());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
