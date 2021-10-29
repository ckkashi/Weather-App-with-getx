import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/models/User.dart';

class UsersController extends GetxController {
  var us = <User>[].obs;

  @override
  void onInit() {
    List users = GetStorage().read('users');

    if (users != null) {
      us = users.map((e) => User.fromJson(e)).toList().obs;
    }
  }
}
