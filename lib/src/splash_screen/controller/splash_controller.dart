import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../home_screen/view/home_main_view.dart';
import '../../login_screen/view/login_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigatTo();
    super.onInit();
  }

  navigatTo() async {
    Timer(Duration(seconds: 3), () async {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null && user.emailVerified) {
        Get.to(() => HomeView());
      } else {
        Get.to(() => LoginView());
      }
    });
  }
}
