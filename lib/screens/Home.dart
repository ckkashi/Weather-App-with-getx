import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/Constants.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherFactory wf =
      WeatherFactory(Constants.apiKey, language: Language.ENGLISH);

  Weather? w;

  List<Weather> forecast = [];

  bool dataAvail = false;

  getWeather(String cityName) async {
    w = await wf.currentWeatherByCityName(cityName);
    forecast = await wf.fiveDayForecastByCityName(cityName);
    print(forecast.length);
    if (w != null) {
      setState(() {
        dataAvail = true;
      });
    }

    // print(forecast);
    // print(w);
  }

  TextEditingController searchCon = TextEditingController();

  String getIcon(String weatherIcon) {
    if (weatherIcon == '01d') {
      return 'assets/01d.png';
    } else if (weatherIcon == '02d') {
      return 'assets/02d.png';
    } else if (weatherIcon == '03d') {
      return 'assets/03d.png';
    } else if (weatherIcon == '04d') {
      return 'assets/04d.png';
    } else if (weatherIcon == '09d') {
      return 'assets/09d.png';
    } else if (weatherIcon == '10d') {
      return 'assets/10d.png';
    } else if (weatherIcon == '11d') {
      return 'assets/11d.png';
    } else if (weatherIcon == '13d') {
      return 'assets/13d.png';
    } else if (weatherIcon == '50d') {
      return 'assets/50d.png';
    } else if (weatherIcon == '01n') {
      return 'assets/01n.png';
    } else if (weatherIcon == '02n') {
      return 'assets/02n.png';
    } else if (weatherIcon == '03n') {
      return 'assets/03d.png';
    } else if (weatherIcon == '04n') {
      return 'assets/04d.png';
    } else if (weatherIcon == '09n') {
      return 'assets/09d.png';
    } else if (weatherIcon == '10n') {
      return 'assets/10d.png';
    } else if (weatherIcon == '11n') {
      return 'assets/11d.png';
    } else if (weatherIcon == '13n') {
      return 'assets/13d.png';
    } else if (weatherIcon == '50n') {
      return 'assets/50d.png';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: app_appbar(),
        body: Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover),
          ),
          child: Container(
            width: 100.w,
            height: 100.h,
            color: Colors.white.withOpacity(0.65),
            child: Stack(
              children: [
                Positioned(
                  left: 2.5.w,
                  top: 2.h,
                  child: search_bar(searchCon),
                ),
                Positioned(
                  left: 2.5.w,
                  top: 14.h,
                  child: Container(
                    width: 95.w,
                    height: 44.h,
                    // color: Colors.black,
                    child: dataAvail == false
                        ? Container(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search,
                                    size: 40.w,
                                  ),
                                  Text(
                                    'Search city name for results',
                                    style: GoogleFonts.lato(fontSize: 18.sp),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              SizedBox(height: 3.h),
                              Text(w!.areaName.toString(),
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(),
                                      fontSize: 20.sp,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 2.h),
                              Text('${w!.temperature!.celsius!.toInt()}',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(),
                                      fontSize: 60.sp,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold)),
                              Text('celsius',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(),
                                      fontSize: 20.sp,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold)),
                              Container(
                                width: 10.w,
                                height: 10.w,
                                child: Image.asset(
                                    getIcon(w!.weatherIcon.toString())),
                              ),
                              Text(
                                w!.weatherDescription.toString(),
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              Text(
                                w!.date!.day.toString() +
                                    ' ' +
                                    w!.date!.month.toString() +
                                    ' ' +
                                    w!.date!.year.toString(),
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ],
                          ),
                  ),
                ),
                Positioned(
                  top:58.h,
                  left: 42.w,
                  child: 
                    
                        Text('Forecast',style: GoogleFonts.lato(
                          fontSize:14.sp,
                        ),),
                   
                  ),
                Positioned(
                  left: 2.5.w,
                  top: 63.h,
                  child: dataAvail != true
                      ? Container()
                      : Container(
                          width: 95.w,
                          height: 22.h,
                          // color: Colors.black,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: forecast.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 30.w,
                                    height: 16.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 1,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              blurRadius: 2)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Column(
                                        children: [
                                          Text(
                                              forecast[index]
                                                  .areaName
                                                  .toString(),
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(),
                                                  fontSize: 13.sp,
                                                  letterSpacing: 1,
                                                  )
                                                  ),
                                          Container(
                                width: 10.w,
                                height: 10.w,
                                child: Image.asset(
                                    getIcon(forecast[index].weatherIcon.toString())),
                              ),
                                          Text('${forecast[index].temperature!.celsius!.toInt()}',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(),
                                      fontSize: 20.sp,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold)),
                              
                              Text(
                                forecast[index].date!.day.toString() +
                                    ' ' +
                                    forecast[index].date!.month.toString() +
                                    ' ' +
                                    forecast[index].date!.year.toString(),
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              Text(
                                forecast[index].date!.hour.toString() +
                                    ' : ' +
                                    forecast[index].date!.minute.toString(),
                                style: TextStyle(fontSize: 12.sp),
                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                ),
              ],
            ),
          ),
        ));
  }

  Container search_bar(TextEditingController con) {
    return Container(
      //search_bar_widget
      width: 95.w,
      height: 10.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: TextField(
          //search_bar_field
          controller: con,
          cursorHeight: 5.h,
          style:
              TextStyle(fontSize: 22.sp, color: Colors.blue, letterSpacing: 1),
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    if (searchCon.text != '')
                      getWeather(searchCon.text);
                    else {
                      Get.snackbar('Error', 'Enter city name for search',
                          snackPosition: SnackPosition.BOTTOM);
                      setState(() {
                        dataAvail = false;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.search,
                    size: 9.w,
                  )),
              border: InputBorder.none,
              hintText: 'Search'),
        ),
      ),
    );
  }

  AppBar app_appbar() {
    return AppBar(
      title: Text('WEATHER App',
          style: GoogleFonts.lato(
              fontSize: 18.sp, letterSpacing: 1, fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.toNamed('/signin');
            },
            icon: Icon(
              Icons.person_pin,
              size: 27.sp,
            ))
      ],
    );
  }
}
