import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/src/adminhome_screen/controller/adminhome_controller.dart';

class AdminHomeAlertDialog {
  static showDeleteItem(
      {required AdminHomeController controller,
      required String type,
      required String documentID}) async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 20.h,
      width: 100.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Delete item?",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "No",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  )),
              TextButton(
                  onPressed: () {
                    if (type == "Grammar") {
                      controller.grammarDeleteItem(documentID: documentID);
                    } else {
                      controller.spellingDeleteItem(documentID: documentID);
                    }
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp),
                  ))
            ],
          )
        ],
      ),
    )));
  }

  static showAddCategory({
    required AdminHomeController controller,
  }) async {
    TextEditingController category = TextEditingController();
    Get.dialog(AlertDialog(
        content: Container(
      height: 20.h,
      width: 100.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Create Category",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            height: 7.h,
            width: 100.w,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(8)),
            child: TextField(
              maxLines: null,
              minLines: null,
              expands: true,
              controller: category,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 2.w, top: 2.h),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Back",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  )),
              TextButton(
                  onPressed: () {
                    controller.createCategoryType(categoryName: category.text);
                  },
                  child: Text(
                    "Create",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp),
                  ))
            ],
          )
        ],
      ),
    )));
  }

  static showUpdateCategory({
    required AdminHomeController controller,
    required String categoryName,
    required String id,
  }) async {
    TextEditingController category = TextEditingController(text: categoryName);

    Get.dialog(AlertDialog(
        content: Container(
      height: 20.h,
      width: 100.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Update Category",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            height: 7.h,
            width: 100.w,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(8)),
            child: TextField(
              maxLines: null,
              minLines: null,
              expands: true,
              controller: category,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 2.w, top: 2.h),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Back",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  )),
              TextButton(
                  onPressed: () {
                    controller.updateCategory(catname: category.text, id: id);
                  },
                  child: Text(
                    "Create",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp),
                  ))
            ],
          )
        ],
      ),
    )));
  }
}
