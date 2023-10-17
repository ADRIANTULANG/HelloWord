import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/config/textstyle.dart';
import 'package:teachlang/src/login_screen/controller/login_controller.dart';

class LoginAlertdialog {
  static showLoadingDialog() async {
    Get.dialog(
        AlertDialog(
          content: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
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
                      const Text("Loading...")
                    ],
                  )),
            ),
          ),
        ),
        barrierDismissible: false);
  }

  static showDialogAdminLogin({required LoginController controller}) async {
    TextEditingController code = TextEditingController();
    Get.dialog(
      AlertDialog(
        content: Container(
          height: 18.h,
          width: 100.w,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                width: 100.w,
                child: Text(
                  "Enter Admin code",
                  style: Styles.header2,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 7.h,
                width: 100.w,
                child: TextField(
                  controller: code,
                  decoration: InputDecoration(
                      fillColor: Colors.lightBlue[50],
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 3.w),
                      alignLabelWithHint: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: 'XXXX'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Back", style: Styles.normalBold)),
                  TextButton(
                      onPressed: () {
                        controller.loginAdmin(code: code.text);
                      },
                      child: Text(
                        "Submit Code",
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
