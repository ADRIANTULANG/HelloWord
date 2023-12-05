import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/src/adminhome_screen/widget/adminhome_alertdialog.dart';

import '../../../config/textstyle.dart';
import '../controller/adminhome_controller.dart';

class AdminCategoryView extends GetView<AdminHomeController> {
  const AdminCategoryView({super.key});

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
                    "Create Category",
                    style: Styles.header1,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 5.w,
                    right: 5.w,
                  ),
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.categoriesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: 2.h,
                          ),
                          child: SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.categoriesList[index].name,
                                      style: Styles.header2,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            AdminHomeAlertDialog
                                                .showUpdateCategory(
                                                    controller: controller,
                                                    categoryName: controller
                                                        .categoriesList[index]
                                                        .name,
                                                    id: controller
                                                        .categoriesList[index]
                                                        .id);
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.deleteCategories(
                                                id: controller
                                                    .categoriesList[index].id);
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const Divider()
                              ],
                            ),
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
          AdminHomeAlertDialog.showAddCategory(controller: controller);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
