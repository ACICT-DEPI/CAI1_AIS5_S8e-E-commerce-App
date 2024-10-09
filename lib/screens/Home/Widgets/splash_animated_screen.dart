import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:e_commerce/screens/Home/Widgets/onboarding_screen.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';



class splash_animated_screen extends StatelessWidget {
  const splash_animated_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 300,
        pageTransitionType: PageTransitionType.leftToRight,
        splashTransition: SplashTransition.rotationTransition,
        splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/4990460.png",
            height: 200,
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
            "Welcome to ",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
               Text(
            "SnapShop",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kprimaryColor, // Adjust color as needed
            ),
          ),
            ],
          )
        ],
      ),

        nextScreen: const OnboardingScreen());

  }
}



