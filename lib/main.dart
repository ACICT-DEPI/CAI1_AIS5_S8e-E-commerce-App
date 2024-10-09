import 'package:e_commerce/provider/cart_provider.dart';
import 'package:e_commerce/provider/favorite_provider.dart';
import 'package:e_commerce/provider/product_viewed_provider.dart';
import 'package:e_commerce/provider/theme_provider.dart';
import 'package:e_commerce/screens/Home/Widgets/splash_animated_screen.dart';
import 'package:e_commerce/screens/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
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
            ChangeNotifierProvider(create: (_) => ViewedProductsProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()), 

          ],
         child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Snap Shop',
          theme: ThemeData(
            textTheme: GoogleFonts.mulishTextTheme(),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: HexColor('333739'),
            appBarTheme: AppBarTheme(
              color: HexColor('333739'),
            ),
          ),
          themeMode: themeProvider.themeMode,
          // Set SplashAnimatedScreen as the initial screen
          home:(FirebaseAuth.instance.currentUser != null &&
                    FirebaseAuth.instance.currentUser!.emailVerified)
                ? const BottomNavBar()
                : const splash_animated_screen(),
        );
      
      
        },
      ),
    );
  }
