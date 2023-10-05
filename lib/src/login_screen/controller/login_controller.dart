import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../home_screen/view/home_main_view.dart';
import '../widget/login_alertdialog.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
  }

  login() async {
    LoginAlertdialog.showLoadingDialog();
    try {
      await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      var user = auth.currentUser!;
      if (user.emailVerified) {
        Get.offAll(() => HomeView());
      } else {
        Get.back();
        Get.snackbar("Message",
            "Your account is not yet verified. Please check your email to verify your account.",
            backgroundColor: Colors.lightBlue, colorText: Colors.white);
        await FirebaseAuth.instance.signOut();
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        Get.back();
        if (e.code == 'invalid-email') {
          Get.snackbar("Message", "Invalid email format",
              backgroundColor: Colors.red, colorText: Colors.white);
        } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          Get.snackbar("Message", "Wrong password",
              backgroundColor: Colors.red, colorText: Colors.white);
        } else if (e.code == 'too-many-requests') {
          Get.snackbar("Message",
              "We have blocked all requests from this device due to unusual activity. Try again later",
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          Get.snackbar("Message", "Login failed with error code: ${e.code}",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.back();
        Get.snackbar("Message", "Login failed: ${e.toString()}",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  googleSignin() async {
    try {
      LoginAlertdialog.showLoadingDialog();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken == null && googleAuth?.idToken == null) {
        print("null ang access token ug idtoken");
        Get.back();
      } else {
        var credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        print("access token: ${googleAuth?.accessToken}");
        print("id token: ${googleAuth?.idToken}");
        UserCredential? userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        await saveUser(
            email: userCredential.user!.email.toString(),
            userid: userCredential.user!.uid);
        Get.offAll(() => HomeView());
      }
    } catch (e) {
      Get.back();
      print("ERROR: $e");
    }
  }

  saveUser({required String email, required String userid}) async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .where("provider", isEqualTo: "gmail")
          .get();
      if (res.docs.length == 0) {
        await FirebaseFirestore.instance.collection('users').add({
          "userid": userid,
          "email": email,
          "isVerified": true,
          "provider": "gmail",
          "imageUrl": "",
          "firstname": "",
          "lastname": "",
          "contactno": "",
          "fcmToken": ""
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
