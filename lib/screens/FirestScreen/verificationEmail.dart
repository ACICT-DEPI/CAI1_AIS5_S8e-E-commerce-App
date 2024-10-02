import 'package:e_commerce/constants/CustomButton.dart';
import 'package:e_commerce/screens/FirestScreen/signin.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:flutter/material.dart';

class VerificationEmail extends StatelessWidget {
  const VerificationEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body:Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child:Column(
            children: [
              const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "Check Your Email",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      "We sent a verifiation link to your email",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    Icons.email_outlined,
                    size: 150,
                    color: kprimaryColor2,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(title: "Verify email",onPressed: (){
                    Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signin()));
                  },)
            ],
          )
        ),
      ),
    );
  }
}