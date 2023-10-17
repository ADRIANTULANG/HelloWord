import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RegistrationController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => controller.isLoading.value == true
            ? SizedBox(
                height: 100.h,
                width: 100.w,
                child: Center(
                  child: SpinKitThreeBounce(
                    color: Colors.lightBlue,
                    size: 50.sp,
                  ),
                ),
              )
            : Container(
                color: Colors.white,
                height: 100.h,
                width: 100.w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 9.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: Container(
                        height: 35.h,
                        width: 100.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage("assets/images/logo.png"))),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      height: 7.h,
                      width: 100.w,
                      child: TextField(
                        controller: controller.email,
                        decoration: InputDecoration(
                            fillColor: Colors.lightBlue[50],
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 3.w),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Email'),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      height: 7.h,
                      width: 100.w,
                      child: TextField(
                        obscureText: true,
                        controller: controller.password,
                        decoration: InputDecoration(
                            fillColor: Colors.lightBlue[50],
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 3.w),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Password'),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: InkWell(
                        onTap: () {
                          if (controller.email.text.isEmail == false) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Invalid email'),
                            ));
                          } else if (controller.password.text.length < 8) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  'The password must be 8 characters long'),
                            ));
                          } else {
                            controller.signUpUser();
                          }
                        },
                        child: Container(
                          height: 7.h,
                          width: 100.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          InkWell(
                            onTap: () async {
                              Get.back();
                            },
                            child: Text(
                              "Sign in.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: InkWell(
                        onTap: () {
                          controller.googleSignin();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 6.h,
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
                                Image.asset("assets/images/googles.png"),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
