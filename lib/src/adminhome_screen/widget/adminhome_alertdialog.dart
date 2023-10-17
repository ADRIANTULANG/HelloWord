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
}
