import 'package:e_commerce/screens/Home/Widgets/onboarding_controller.dart';
import 'package:e_commerce/screens/Home/Widgets/static.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class customerslider extends GetView<OnboardingControllerImp> {
  const customerslider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: (val) {
          controller.onPageChanged(val);
        },
        itemCount: onBoardingList.length,
        itemBuilder: (context, i) => SingleChildScrollView( // Added this
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0), // Adjust top margin here
                child: Text(
                  onBoardingList[i].title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Image.asset(
                onBoardingList[i].image!,
                width: 200,
                height: 230,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 80),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  onBoardingList[i].body!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    height: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
