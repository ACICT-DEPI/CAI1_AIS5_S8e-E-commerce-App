
import 'package:e_commerce/screens/Home/Widgets/static.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class OnboardingController extends GetxController {
  next();
  previous(); // Add the previous method here
  onPageChanged(int index);
}


class OnboardingControllerImp extends GetxController {
  var currentpage = 0; // Initial page index
  PageController pageController = PageController();

  void onPageChanged(int index) {
    currentpage = index;
    update(); // Notify listeners about the change
  }

  void next() {
    if (currentpage < onBoardingList.length - 1) {
      currentpage++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Navigate to another screen (like the home screen)
      // Example: Get.offAll(HomeScreen());
    }
    update(); // Notify listeners about the change
  }
  void previous() {
    if (currentpage > 0) {
      currentpage--;
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
    update(); // Notify listeners about the change
  }

}
