import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices extends GetxController {
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  saveCredentials({
    required String id,
    required String password,
    required String email,
    required String firstname,
    required String lastname,
    required String image,
    required String contactno,
  }) {
    storage.write("id", id);
    storage.write("password", password);
    storage.write("email", email);
    storage.write("firstname", firstname);
    storage.write("lastname", lastname);
    storage.write("contactno", contactno);
    storage.write("image", image);
  }

  removeStorageCredentials() {
    storage.remove("id");
    storage.remove("email");
    storage.remove("password");
    storage.remove("firstname");
    storage.remove("lastname");
    storage.remove("contactno");
    storage.remove("image");
  }
}
