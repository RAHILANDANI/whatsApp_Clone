import 'dart:async';

import 'package:chat_application/viwes/splash_screen/splash_screen_controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? islogin;

  @override
  void initState() {
    islogindata();
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () =>
          (islogin == true) ? Get.offAllNamed('/') : Get.offAllNamed('/login'),
    );
  }

  islogindata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    islogin = preferences.getBool('islogin');
    print("=====================");
    print(islogin);
    print("=====================");
  }

  @override
  Widget build(BuildContext context) {
    // Get.put(SplashScreenController());
    return Scaffold(
      body: Center(
        child: Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/WhatsApp_icon.png"),
            ),
          ),
        ),
      ),
    );
  }
}
