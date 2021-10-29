import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/User.dart';
import 'package:weather_app/screens/Home.dart';
import 'package:weather_app/screens/forms/Signin.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailCon = TextEditingController();

  TextEditingController passCon = TextEditingController();

  var form_text_style = TextStyle(fontSize: 22.sp);

  var form_label_style = TextStyle(fontSize: 15.sp);

  var field_border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(width: 2.w, style: BorderStyle.solid));

  List<User> users = [];

  final storage = GetStorage();

  addUser(String email, String pass) {
    bool alreadyRegistered = false;
    for (User userr in users) {
      if(userr.email == email){
        setState(() {
          alreadyRegistered = true;
        });
        Get.snackbar('Error', 'This email is already registered.',snackPosition: SnackPosition.BOTTOM);
      }
    }
    if(alreadyRegistered==false){
      users.add(User(email: emailCon.text, pass: passCon.text));
      var res = storage.write("users", users);
      Get.offAll(Home());
      print(users);
      Get.snackbar('Successfully registered','You registered this email successfully',snackPosition: SnackPosition.BOTTOM);
      
    }
    
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    try{
      if (storage.read('users') == null) {
      users.add(User(email: 'chk', pass: 'chk'));
      print({'blank':users});
    } else {
      setState(() {
        users = storage.read('users');
      });
      print(users);

    }
    }catch(e){};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'), centerTitle: true),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 100.w,
                height: 100.h,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Icon(
                        Icons.cloud_circle_rounded,
                        size: 100.sp,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (!GetUtils.isEmail(value!))
                              return "Email is not valid";
                            else
                              return null;
                          },
                          controller: emailCon,
                          style: form_text_style,
                          decoration: InputDecoration(
                              labelText: 'Enter E-mail',
                              labelStyle: form_label_style,
                              border: field_border),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: TextFormField(
                          controller: passCon,
                          style: form_text_style,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Enter Password',
                              labelStyle: form_label_style,
                              border: field_border),
                        ),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Center(
                          child: ElevatedButton(
                              onPressed: () {
                                if (emailCon.text == '') {
                                  Get.snackbar('Error', 'Fill all fields.',
                                      snackPosition: SnackPosition.BOTTOM);
                                } else {
                                  if (passCon.text == '') {
                                    Get.snackbar('Error', 'Fill all fields.',
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    String pass = passCon.text;
                                    if (pass.length >= 7) {
                                      addUser(emailCon.text, passCon.text);
                                    } else {
                                      Get.snackbar('Error',
                                          'Password must be of 8 Character',
                                          snackPosition: SnackPosition.BOTTOM);
                                    }
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Register',
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ))),
                    ],
                  ),
                ),
              )),

        ],
      ),
    );
  }
}
