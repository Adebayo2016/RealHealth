import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_health/Home.dart';
import 'package:real_health/login.dart';

class BlessedSplashScreen extends StatefulWidget {
  const BlessedSplashScreen({super.key});

  @override
  State<BlessedSplashScreen> createState() => _BlessedSplashScreenState();
}

class _BlessedSplashScreenState extends State<BlessedSplashScreen> {

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: 200,
                child: Image.asset(
                  'assets/ble.png',
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  // height: MediaQuery.sizeOf(context).height / 2,
                ),
              ),
            ),
            SizedBox(height: 26),
            Text(
              'Welcome to\nReal Health',
              textAlign: TextAlign.center,

            ),
            SizedBox(height: 47),
            Text(
             '''
            Your Ultimate Lifelong Learning
            Companion! Blessed Academy
            empowers you to explore, grow, and
            excel on your journey of lifelong learning.
            ''',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 26),
            // ButtonWidget(
            //   buttonText: 'Get Started',
            //   radius: 12,
            //   fontSize: 16.sp,
            //   fontWeight: FontWeight.w600,
            //   height: 54.h,
            //   padding: const EdgeInsets.symmetric(horizontal: 40),
            //   icon: 'assets/icons/arrow_right.svg',
            //   iconColor: kColorWhite,
            //   onPressed: () {
            //     navigate(context, const BlessedHome());
            //   },
            //   color: kColorWhite,
            // ),
            // SizedBox(height: 38.h),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      //navigateReplace(context, const TabLayout());
      print(timer.tick.toString());

      if (timer.tick == 1) {
        setState(() {
          _visible = true;
        });
      }
      if (timer.tick == 2) {
        FirebaseAuth.instance.userChanges().listen((User? user) {
          if (user == null) {
            Get.to(() => const Login());
          } else {
            Get.to(() => const Home());
          }
        });
        timer.cancel();
      }

    });

  }
}
