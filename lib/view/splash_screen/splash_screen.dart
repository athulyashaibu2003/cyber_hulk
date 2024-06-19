//import 'package:cybot_design/view/chat_home_screen/chat_homescreen.dart';
import 'dart:async';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/view/bottom_navigationbar_screens/bottom_navigation_screeb.dart';
import 'package:cyber_hulk/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.isLoggedIn});

  final bool isLoggedIn;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                widget.isLoggedIn ? BottomNavigationScreen() : LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.mainwhite,
      // appBar: AppBar(
      //   backgroundColor: Colorconstant.pantonemessage,
      //   actions: [Text("Version 1.0.0")],
      // ),
      // appBar: AppBar(
      //   actions: [
      //     SizedBox(
      //       child: Icon(
      //         Icons.notifications_outlined,
      //         size: 35,
      //       ),
      //       width: 50,
      //     )
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Image.asset(
                  // "assets/images/Artboard 3_PURPLE copy.png",
                  "assets/images/CH green final.png",
                  height: MediaQuery.sizeOf(context).height * .25,
                ),
              ),
            ]),
            Container(
              color: ColorConstant.mainblack,
              height: 50,
              width: double.infinity,
              child: Center(
                child: Text(
                  "Developed by Avanzo Cyber Security Solutions",
                  style:
                      TextStyle(fontSize: 10, color: ColorConstant.mainwhite),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
