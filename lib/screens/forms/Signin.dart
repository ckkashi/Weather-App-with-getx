import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/User.dart';
import 'package:weather_app/screens/UserProfile.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailCon = TextEditingController();

  TextEditingController passCon = TextEditingController();

  var form_text_style = TextStyle(fontSize: 22.sp);

  var form_label_style = TextStyle(fontSize: 15.sp);

  var field_border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(width: 2.w, style: BorderStyle.solid));

  // List<User> users = [User(email: 'for run',pass: 'for run')];
  List<User> users = [];
  final storage = GetStorage();
  bool isUserLogin = false;

  getUser(String email, String pass) {
    // getData();
    bool notFound = false;
    bool wrongPassword = false;
    bool userLogin = false;
    for (var userr in users) {
      if (userr.email == email) {
        print(userr.email);
        if (userr.pass == pass) {
          print(userr.pass);
          setState(() {
            userLogin = true;
          });
        } else {
          setState(() {
            wrongPassword = true;
          });
        }
      } else {
        setState(() {
          notFound = true;
        });
      }
    }
    if (userLogin == false) {
      if (notFound) {
        Get.snackbar('Error', 'User not found for this email.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (wrongPassword) {
        Get.snackbar('Error', 'Incorrect password.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else if (userLogin) {
      storage.write('isUserLogin', userLogin);
      storage.write('userData', User(email: email, pass: pass));
      Get.off(UserProfile());
      Get.snackbar('Successfully login', 'you are login.',
          snackPosition: SnackPosition.BOTTOM);
      storage.read('isUserLogin');
    }
  }

  getData() {
    var usersDup = {"email": 'forRun ', "pass": 'for run'};
    try {
      setState(() {
        users = storage.read('users') /*!= null ? storage.read('users') : []*/;
        isUserLogin = storage.read(
            'isUserLogin') /* == null ? false : storage.read('isUserLogin')*/;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      if (storage.read('users') == null) {
        users.add(User(email: 'chk', pass: 'chk'));
      } else {
        setState(() {
          users = storage.read('users');
        });

        if (storage.read('isUserLogin') == null) {
          setState(() {
            isUserLogin = false;
          });
        } else {
          setState(() {
            isUserLogin = storage.read('isUserLogin');
          });
        }
      }
    } catch (e) {
      print(e);
    }

    print({'isUserLogin': isUserLogin});
    print({'users find in login': users});
  }

  @override
  Widget build(BuildContext context) {
    print(isUserLogin);
    return isUserLogin
        ? UserProfile()
        : Scaffold(
            appBar: AppBar(title: Text('Login'), centerTitle: true),
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
                                controller: emailCon,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (!GetUtils.isEmail(value!))
                                    return "Email is not valid";
                                  else
                                    return null;
                                },
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                        Get.snackbar(
                                            'Error', 'Fill all fields.',
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      } else {
                                        if (passCon.text == '') {
                                          Get.snackbar(
                                              'Error', 'Fill all fields.',
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                        } else {
                                          String pass = passCon.text;
                                          if (pass.length >= 7) {
                                            getUser(
                                                emailCon.text, passCon.text);
                                          } else {
                                            Get.snackbar('Error',
                                                'Password must be of 8 Character',
                                                snackPosition:
                                                    SnackPosition.BOTTOM);
                                          }
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                    top: 80.h,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                        child: TextButton(
                            onPressed: () {
                              Get.toNamed('/signup');
                            },
                            child: Text(
                              'Create Account ?',
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold)),
                            )))),
              ],
            ),
          );
  }
}
