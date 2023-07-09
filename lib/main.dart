import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/store.dart';
import 'package:flutter_application_1/db/db-constant.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/utilities/my_routes.dart';
import 'package:flutter_application_1/widgets/theme.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'pages/signup_page.dart';

void main() {
  DBHelper.connect();
  runApp(VxState(store: AppStore(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const LoginPage(),
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.cartRoute: (context) => const CartPage(),
        MyRoutes.signUpRoute: (context) => const SignUpPage(),
        MyRoutes.checkoutRoute: (context) => const CheckoutPage()
      },
    );
  }
}
