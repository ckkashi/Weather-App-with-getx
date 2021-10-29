import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/Home.dart';
import 'package:weather_app/screens/Splash.dart';
import 'package:weather_app/screens/forms/Signin.dart';
import 'package:weather_app/screens/forms/Signup.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,orientation,deviceType){
        return GetMaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            // fontFamily: ,
          ),
          initialRoute: '/splash',
          getPages: [
            GetPage(name: '/splash', page: ()=>Splash()),
            GetPage(name: '/home', page: ()=>Home(),transition: Transition.fade),
            GetPage(name: '/signin', page: ()=>Signin(),transition: Transition.fade),
            GetPage(name: '/signup', page: ()=>Signup(),transition: Transition.fade),
          ],
        );
      },
    );
  }
}