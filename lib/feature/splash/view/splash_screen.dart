import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/feature/home/view/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: ZoomIn(
                duration: const Duration(seconds: 2),
                  child: Image.asset('assets/logo/logo.png')),
            ),
          ),
          Center(
            child: FadeInUp(
              delay: const Duration(seconds: 2),
                onFinish: (_){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                },
                child: Image.asset('assets/logo/route.png', height: 100)),
          )
        ],
      ),
    );
  }
}
