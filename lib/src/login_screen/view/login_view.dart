import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/config/custom_icons.dart';
import 'package:teachlang/src/login_screen/widget/login_alertdialog.dart';
import '../../registration_screen/view/registration_view.dart';
import '../controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                  controller.login();
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
                    "Login",
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
                    "Dont have an account? ",
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
                      Get.to(() => const RegistrationView());
                    },
                    child: Text(
                      "Sign up.",
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
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: InkWell(
                onTap: () async {
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
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: InkWell(
                onTap: () async {
                  LoginAlertdialog.showDialogAdminLogin(controller: controller);
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
                        SvgPicture.asset(
                          CustomIcons.adminaccount,
                          width: 4.w,
                          height: 4.h,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "Continue as Admin",
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
          ],
        ),
      ),
    );
  }
}
