import 'package:e_commerce/provider/cart_provider.dart';
import 'package:e_commerce/provider/favorite_provider.dart';
import 'package:e_commerce/screens/FirestScreen/signin.dart';
import 'package:e_commerce/screens/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('-----------------------User is currently signed out!');
      } else {
        print('-----------------------User is signed in!');
      }
    });
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                textTheme: GoogleFonts.mulishTextTheme(),
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home:(FirebaseAuth.instance.currentUser!= null && FirebaseAuth.instance.currentUser!.emailVerified) ? BottomNavBar(): Signin())
              );
}
