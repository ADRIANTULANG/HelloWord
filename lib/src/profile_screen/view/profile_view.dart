import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/src/profile_screen/controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Obx(
          () => controller.isLoading.value == true
              ? Center(
                  child: SpinKitThreeBounce(
                    color: Colors.lightBlue,
                    size: 50.sp,
                  ),
                )
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      height: 6.h,
                      width: 100.w,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black45))),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 15.sp,
                              color: Colors.lightBlue,
                            ),
                          ),
                          SizedBox(
                            width: 2.5.w,
                          ),
                          Expanded(
                              child: SizedBox(
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 13.sp),
                            ),
                          ))
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.getImage();
                      },
                      child: Obx(
                        () => controller.filename.value == ''
                            ? Container(
                                height: 30.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            controller.imageLink.value))),
                              )
                            : Container(
                                height: 30.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            controller.pickedImage!))),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Account Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      height: 7.h,
                      width: 100.w,
                      child: TextField(
                        controller: controller.firstname,
                        decoration: InputDecoration(
                            fillColor: Colors.lightBlue,
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 3.w),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: "First name"),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      height: 7.h,
                      width: 100.w,
                      child: TextField(
                        controller: controller.lastname,
                        decoration: InputDecoration(
                            fillColor: Colors.lightBlue,
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 3.w),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: "Last name"),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      height: 7.h,
                      width: 100.w,
                      child: TextField(
                        controller: controller.contactno,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          if (controller.contactno.text.isEmpty) {
                          } else {
                            if (controller.contactno.text[0] != "9" ||
                                controller.contactno.text.length > 10) {
                              controller.contactno.clear();
                            } else {}
                          }
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.lightBlue,
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 3.w),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: "Phone no."),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    //   height: 7.h,
                    //   width: 100.w,
                    //   child: TextField(
                    //     enabled: false,
                    //     controller: controller.email,
                    //     decoration: InputDecoration(
                    //         fillColor: Colors.lightBlue,
                    //         filled: true,
                    //         contentPadding: EdgeInsets.only(left: 3.w),
                    //         alignLabelWithHint: false,
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(8)),
                    //         labelText: "Email"),
                    //   ),
                    // ),
                  ],
                ),
        ),
      )),
      bottomNavigationBar: Obx(
        () => controller.isLoading.value == true
            ? const SizedBox()
            : InkWell(
                onTap: () {
                  if (controller.firstname.text.isEmpty ||
                      controller.lastname.text.isEmpty ||
                      controller.contactno.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please provide all the information'),
                    ));
                  } else if (controller.contactno.text.length != 10) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please enter a valid contact number'),
                    ));
                  } else {
                    controller.upDateAcountInfo();
                    FocusScope.of(context).unfocus();
                    Get.snackbar("Message", "Account info updated",
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  }
                },
                child: Container(
                  height: 8.h,
                  width: 100.w,
                  color: Colors.lightBlue[900],
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Update Account",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.shopping_bag_rounded,
                        size: 20.sp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
