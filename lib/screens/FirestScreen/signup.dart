import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce/provider/theme_provider.dart';
import 'package:e_commerce/screens/FirestScreen/verificationEmail.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constants/CustomButton.dart';
import 'package:e_commerce/constants/CustomTextForm.dart';
import 'package:e_commerce/screens/FirestScreen/signin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool rememberMe = false;
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPasswoed = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

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
        leading: const BackButton(),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(themeProvider.isDarkMode
                    ? Icons.nights_stay
                    : Icons.wb_sunny,
                    color: kprimaryColor,),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: SingleChildScrollView(
            child: Form(
              key: formState,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "Sign Up for Free",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextForm(
                      hintText: "Your User Name",
                      keyboardType: TextInputType.text,
                      myControler: userName,
                      isPassword: false,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your User Name';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
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
                        String pattern =
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(val)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      }),
                  const SizedBox(
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
                        if (val.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextForm(
                      hintText: "Your Confirm Password",
                      keyboardType: TextInputType.text,
                      myControler: confirmPasswoed,
                      isPassword: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (val != password.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    title: "Sign Up",
                    onPressed: () async {
                      if (formState.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VerificationEmail()));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                            AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'ERROR',
                                    desc: 'The password provided is too weak.')
                                .show();
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'ERROR',
                              desc:
                                  'The account already exists for that email.',
                            ).show();
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "or Sign Up with",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
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
                        child: const Image(
                          image: NetworkImage(
                              "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png"),
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      MaterialButton(
                        height: 60,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.white,
                        onPressed: () {},
                        child: const Image(
                          image: NetworkImage(
                              "https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/83-facebook-512.png"),
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signin()));
                          },
                          child: const Text(
                            "Sign in",
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
