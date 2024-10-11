import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce/provider/theme_provider.dart';
import 'package:e_commerce/screens/FirestScreen/forget_password.dart';
import 'package:e_commerce/screens/bottom_nav_bar.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constants/CustomButton.dart';
import 'package:e_commerce/constants/CustomTextForm.dart';
import 'package:e_commerce/screens/FirestScreen/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        await googleUser.authentication;

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
    _loadUserCredentials();
  }

  // Load user credentials if "Remember Me" was checked
  void _loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('remember_me') ?? false;
      if (rememberMe) {
        email.text = prefs.getString('email') ?? '';
        password.text = prefs.getString('password') ?? '';
      }
    });
  }

  // Save user credentials if "Remember Me" is checked
  void _saveUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString('email', email.text);
      await prefs.setString('password', password.text);
    }
    await prefs.setBool('remember_me', rememberMe);
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
                      "Sign in to Your Account",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
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
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      const Text('Remember Me'),
                      const SizedBox(
                        width: 80,
                      ),
                      TextButton(
                        child: const Text("Forget Password",
                            style: TextStyle(
                              color: kprimaryColor2,
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()));
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: "Sign in",
                    onPressed: () async {
                      if (formState.currentState!.validate()) {
                        _saveUserCredentials();
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
                                    builder: (context) =>
                                        const BottomNavBar()));
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "or Sign in with",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
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
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            _saveUserCredentials();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signup()));
                          },
                          child: const Text(
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
