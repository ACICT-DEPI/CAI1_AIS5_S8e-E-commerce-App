import 'package:e_commerce/screens/bottom_nav_bar.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Success'),
        automaticallyImplyLeading: false, // To prevent back navigation
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'images/animation/success.json', 
         width: 200,
              height: 200,

            ),
            SizedBox(height: 20),
            Text(
              'Payment Successful!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Thank you for your payment. Your transaction is complete.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return BottomNavBar();
                  },
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kprimaryColor,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                'Go to Home',
                style: TextStyle(fontSize: 18 ,color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
