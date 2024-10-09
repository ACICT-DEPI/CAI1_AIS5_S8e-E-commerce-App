import 'package:e_commerce/screens/Home/Widgets/color.dart';
import 'package:e_commerce/screens/Home/Widgets/onboarding_controller.dart';
import 'package:e_commerce/screens/Home/Widgets/static.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class controller extends StatelessWidget {
  const controller({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0), // Add your desired top margin here
      child: GetBuilder<OnboardingControllerImp>(
        builder: (controller) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(onBoardingList.length, (index) => AnimatedContainer(
              margin: const EdgeInsets.only(right: 5),
              duration: const Duration(milliseconds: 900),
              width: controller.currentpage == index ? 20 : 5,
              height: 6,
              decoration: BoxDecoration(
                color: Appcolor.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
