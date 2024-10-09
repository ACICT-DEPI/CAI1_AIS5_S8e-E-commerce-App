

import 'package:e_commerce/screens/Home/Widgets/cusslider.dart';
import 'package:e_commerce/screens/Home/Widgets/custombutton.dart';
import 'package:e_commerce/screens/Home/Widgets/dotcontroller.dart';
import 'package:e_commerce/screens/Home/Widgets/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingControllerImp());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 3,
              child: customerslider(), // Ensure this is the correct casing
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const controller(), // Ensure this is the correct casing
                  const Spacer(flex: 2),
                  GetBuilder<OnboardingControllerImp>(
                    builder: (controller) => CustomButton(currentPage: controller.currentpage), // Ensure casing is correct
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
