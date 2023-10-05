import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../home_screen/view/home_main_view.dart';

class RegistrationController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  signUpUser() async {
    try {
      isLoading(true);
      List<String> signInMethods =
          await auth.fetchSignInMethodsForEmail(email.text);
      print(signInMethods);
      if (signInMethods.isNotEmpty) {
        Get.snackbar("Message", "Email already exist",
            backgroundColor: Colors.lightBlue, colorText: Colors.white);
      } else {
        await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        var user = auth.currentUser!;
        await user.sendEmailVerification();

        await saveUser(userid: user.uid);
        await FirebaseAuth.instance.signOut();
        Get.back();
        Get.snackbar("Message",
            "Account created. We have sent an email to verify your account.",
            backgroundColor: Colors.lightBlue, colorText: Colors.white);
      }
    } catch (e) {
      print(e);
    }
    isLoading(false);
  }

  saveUser({required String userid}) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        "userid": userid,
        "email": email.text,
        "isVerified": false,
        "provider": "email",
        "imageUrl": "",
        "firstname": "",
        "lastname": "",
        "contactno": "",
        "fcmToken": ""
      });
    } catch (e) {
      print(e);
    }
  }

  googleSignin() async {
    isLoading(true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken == null && googleAuth?.idToken == null) {
        print("null ang access token ug idtoken");
      } else {
        var credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        print("access token: ${googleAuth?.accessToken}");
        print("id token: ${googleAuth?.idToken}");
        UserCredential? userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        await saveUserForGoogleSignIn(
            email: userCredential.user!.email.toString(),
            userid: userCredential.user!.uid);
        Get.offAll(() => HomeView());
      }
    } catch (e) {
      print("ERROR: $e");
    }
    isLoading(false);
  }

  saveUserForGoogleSignIn(
      {required String email, required String userid}) async {
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
