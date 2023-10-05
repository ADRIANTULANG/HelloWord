import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginAlertdialog {
  static showLoadingDialog() async {
    Get.dialog(
        AlertDialog(
          content: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                  height: 8.h,
                  width: 60.w,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Center(
                        child: SpinKitThreeBounce(
                          size: 25.sp,
                          color: Colors.lightBlue,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("Loading...")
                    ],
                  )),
            ),
          ),
        ),
        barrierDismissible: false);
  }
}
