import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/User.dart';
import 'package:weather_app/screens/forms/Signin.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final storage = GetStorage();
  // var user;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   try {
  //     user = storage.read('userData');
  //     print(user);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Logout',
                  content: Text('Are you sure?'),
                  onConfirm: () {
                    storage.write('isUserLogin', false);
                    storage.write('userData', 'null');
                    print('true');
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    print('false');
                  },
                );
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Text('user profile'),
      ),
    );
  }
}
