import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/home.dart';
import 'package:weather_app/loading.dart';
import 'package:weather_app/search_loading.dart';

void main() {
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_ ,child ) => MaterialApp(
          debugShowCheckedModeBanner: false,

          initialRoute: '/',
          routes: {
            '/' : (context) =>Loading(),
            '/home' : (context) =>Home(),
            '/searchloading' : (context)=>SearchLoading(),
          },
      ),
      designSize: Size(1080 , 2400),
    ) ;
  }
}

