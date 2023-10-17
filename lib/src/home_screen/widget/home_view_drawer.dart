import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:teachlang/src/profile_screen/view/profile_view.dart';
import '../../../config/custom_icons.dart';
import '../controller/home_controller.dart';
import 'home_view_alertdialog.dart';

class HomeScreenAppDrawer {
  static showAppDrawer({required HomeController controller}) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
              height: 15.h,
              width: 100.w,
              child: Image.asset("assets/images/logo.png")),
          SizedBox(
            height: 3.h,
          ),
          ListTile(
            leading: SvgPicture.asset(
              CustomIcons.profilerperson,
              color: Colors.black,
              height: 4.h,
              width: 4.w,
            ),
            title: const Text('Profile'),
            onTap: () {
              Get.to(() => const ProfileView());
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              CustomIcons.logout,
              color: Colors.black,
              height: 3.5.h,
              width: 3.5.w,
            ),
            title: const Text('Log out'),
            onTap: () async {
              Get.back();
              HomeScreenAlertDialog.showLogoutConfirmation(
                  controller: controller);
            },
          ),
        ],
      ),
    );
  }
}
