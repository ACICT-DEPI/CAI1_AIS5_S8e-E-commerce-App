import 'package:e_commerce/screens/FirestScreen/signin.dart';
import 'package:e_commerce/screens/Home/Widgets/onboarding_controller.dart';
import 'package:e_commerce/screens/Home/Widgets/static.dart';
import 'package:e_commerce/screens/constans.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends GetView<OnboardingControllerImp> {
  final int currentPage;

  const CustomButton({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (currentPage > 0)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kprimaryColor,
              ),
              onPressed: () {
                print("Back button pressed, current page: $currentPage");
                controller.previous();
              },
              child: const Text("Back",style: TextStyle(color: Colors.white),),
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kprimaryColor,
            ),
            onPressed: () {
              print("Button pressed, current page: $currentPage");
              if (currentPage == onBoardingList.length - 1) {
                print("Navigating to BottomNavBar");
                Get.offAll(() => const Signin());
              } else {
                controller.next();
              }
            },
            child: Text(currentPage == onBoardingList.length - 1 ? "Let's Shop" : "Continue",style: const TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
