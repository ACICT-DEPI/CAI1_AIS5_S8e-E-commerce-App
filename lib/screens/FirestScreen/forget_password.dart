import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce/constants/CustomButton.dart';
import 'package:e_commerce/constants/CustomTextForm.dart';
import 'package:e_commerce/screens/FirestScreen/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: SingleChildScrollView(
            child: Form(
              key: formState,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Forget Password",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Please enter your email address. you well recevie a link to create or set new password via email.",
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomTextForm(
                    hintText: "Your Email Address",
                    keyboardType: TextInputType.emailAddress,
                    isPassword: false,
                    myControler: email,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    title: "Send email",
                    onPressed: () async {
                      if (formState.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email.text);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'send email',
                            desc: 'please go to email to change password.',
                          ).show();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signin()));
                        } catch (e) {
                          print(e);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'ERROR',
                            desc: 'please enter exists email.',
                          ).show();
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
