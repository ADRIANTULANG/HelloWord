import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  final ImagePicker picker = ImagePicker();
  File? pickedImage;
  RxString imagePath = ''.obs;
  RxString filename = ''.obs;
  Uint8List? uint8list;
  RxBool isLoading = true.obs;

  UploadTask? uploadTask;
  RxString imageLink =
      'https://firebasestorage.googleapis.com/v0/b/teachlanguage-cbeb0.appspot.com/o/profilenew.jpg?alt=media&token=e1b2e99f-faa7-494c-9b50-44a9434fa525&_gl=1*1a54zm7*_ga*MTgxNTgwMjk1OS4xNjk2MzA5NDc2*_ga_CW55HF8NVT*MTY5NjQ5ODQ3Ny4xMy4xLjE2OTY0OTkwODguNDEuMC4w'
          .obs;

  TextEditingController contactno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController firstname = TextEditingController();

  getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var userres = await FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: user!.uid)
        .limit(1)
        .get();
    if (userres.docs.isNotEmpty) {
      var userInfo = userres.docs[0].data();
      firstname.text = userInfo['firstname'];
      lastname.text = userInfo['lastname'];
      contactno.text = userInfo['contactno'];
      if (userInfo['imageUrl'] != '') {
        imageLink.value = userInfo['imageUrl'];
      }
    } else {}
    isLoading(false);
  }

  getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image.path);
      imagePath.value = pickedImage!.path;
      filename.value = pickedImage!.path.split('/').last;
      uint8list = Uint8List.fromList(File(imagePath.value).readAsBytesSync());
    }
  }

  upDateAcountInfo() async {
    isLoading(true);
    if (pickedImage != null) {
      final ref =
          FirebaseStorage.instance.ref().child("files/${filename.value}");
      uploadTask = ref.putData(uint8list!);
      final snapshot = await uploadTask!.whenComplete(() {});
      imageLink.value = await snapshot.ref.getDownloadURL();
    }
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var userres = await FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: user!.uid)
        .limit(1)
        .get();
    if (userres.docs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userres.docs[0].id)
          .update({
        "contactno": contactno.text,
        "firstname": firstname.text,
        "lastname": lastname.text,
        "imageUrl": imageLink.value
      });
    }
    isLoading(false);
  }
}
