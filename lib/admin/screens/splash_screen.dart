import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerce/admin/public/route_method.dart';

import 'package:ecommerce/admin/screens/business_category_screen.dart';
import 'package:ecommerce/admin/screens/home_screen.dart';
import 'package:ecommerce/admin/screens/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final getstorage = GetStorage();
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      if (getstorage.read("id") != null) {
        check(context, HomePage(), ChooseBusiness()); //--->route method
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const textColor = [
      Color(0xff7E49DD),
      Color(0xff14E1F9),
    ];

    return Scaffold(
      backgroundColor: const Color(0xff010914),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 58,
                ),
                child: const Image(
                    image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/ecommerce-c053d.appspot.com/o/WhatsApp_Image_2022-09-27_at_8.53.59_PM-removebg-preview%20(1).png?alt=media&token=51429f8f-3e08-401e-915b-d6c49ec401cb'))),
            const SizedBox(
              height: 5,
            ),
            AnimatedTextKit(animatedTexts: [
              ColorizeAnimatedText(
                'Shopeaze',
                textStyle: GoogleFonts.poppins(
                  fontSize: 35.0,
                ),
                colors: textColor,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
