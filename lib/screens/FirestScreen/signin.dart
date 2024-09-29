import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce/screens/bottom_nav_bar.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constants/CustomButton.dart';
import 'package:e_commerce/constants/CustomTextForm.dart';
import 'package:e_commerce/screens/FirestScreen/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool rememberMe = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw Exception("Google sign-in was canceled.");
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void initState() {
    super.initState();
  }

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
                      "Sign in to Your Account",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextForm(
                      hintText: "Your Email Address",
                      keyboardType: TextInputType.emailAddress,
                      myControler: email,
                      isPassword: false,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your email';
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextForm(
                      hintText: "Your Password",
                      keyboardType: TextInputType.text,
                      myControler: password,
                      isPassword: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your password';
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      Text('Remember Me'),
                      SizedBox(
                        width: 80,
                      ),
                      TextButton(
                        child: Text("Forget Password",
                            style: TextStyle(
                              color: kprimaryColor2,
                            )),
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: "Sign in",
                    onPressed: () async {
                      if (formState.currentState!.validate()) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Form is valid')),
                        // );
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                          if (credential.user!.emailVerified) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar()));
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'verified your email',
                              desc: 'please go to email and verify it.',
                            ).show();
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'ERROR',
                              desc: 'No user found for that email.',
                            ).show();
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'ERROR',
                              desc: 'Wrong password provided for that user.',
                            ).show();
                          }
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'ERROR',
                            desc: 'Wrong email or password',
                          ).show();
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "or Sign in with",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        height: 60,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.white,
                        onPressed: () {
                          signInWithGoogle();
                        },
                        child: Image(
                          image: NetworkImage(
                              "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png"),
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      MaterialButton(
                        height: 60,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.white,
                        onPressed: () {},
                        child: Image(
                          image: NetworkImage(
                              "https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/83-facebook-512.png"),
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14,
                              color: kprimaryColor2,
                            ),
                          ))
                    ],
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
