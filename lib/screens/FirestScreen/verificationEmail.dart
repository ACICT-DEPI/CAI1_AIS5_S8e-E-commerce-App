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
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body:Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child:Column(
            children: [
              SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Check Your Email",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "We sent a verifiation link to your email",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.email_outlined,
                    size: 150,
                    color: kprimaryColor2,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(title: "Verify email",onPressed: (){
                    Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signin()));
                  },)
            ],
          )
        ),
      ),
    );
  }
}