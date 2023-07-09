import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/utilities/my_routes.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:velocity_x/velocity_x.dart';
import '../db/db-constant.dart';
import '../models/users.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    // loadUsersData();
  }

  loadUsersData() async {
    try {
      await DBHelper.connect();
      final userData = await DBHelper.getUsers();

      // Convert the data to User objects
      final users =
          userData.map<User>((userMap) => User.fromMap(userMap)).toList();

      UserModel.users = users;

      if (UserModel.users.isNotEmpty) {
        if (kDebugMode) {
          print("Users data loaded successfully");
        }
      }
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error loading user data"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  // loadUsersData() async {
  //   var userJSON = await rootBundle.loadString("assets/files/user.json");
  //   final decodedJSON = jsonDecode(userJSON);
  //   final usersData = decodedJSON["users"];

  //   UserModel.users =
  //       List.from(usersData).map<User>((user) => User.fromMap(user)).toList();

  //   if (UserModel.users.isNotEmpty) {
  //     if (kDebugMode) {
  //       print("Users data loaded successfully");
  //     }
  //   }
  //   setState(() {});
  // }

  String email = "";
  String password = "";
  bool tapButton = false;

  final _formKey = GlobalKey<FormState>();

  // moveToHome(BuildContext context) async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       tapButton = true;
  //     });
  //     await Future.delayed(const Duration(seconds: 1));

  //     // Check if the user exists by email
  //     final user = UserModel.getByEmail(email);

  //     if (user != null) {
  //       // Validate the password
  //       if (user.password == password) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text("Logged In"),
  //             duration: Duration(seconds: 1),
  //           ),
  //         );
  //         await Navigator.pushNamed(context, MyRoutes.homeRoute);
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text("Incorrect Password"),
  //             duration: Duration(seconds: 1),
  //           ),
  //         );
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("User not found"),
  //           duration: Duration(seconds: 1),
  //         ),
  //       );
  //     }

  //     setState(() {
  //       tapButton = false;
  //     });
  //   }
  // }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        tapButton = true;
      });
      await Future.delayed(const Duration(seconds: 1));

      // Check if the user exists by email
      final user = UserModel.getByEmail(email);

      if (user != null) {
        // Validate the password
        if (user.password == password) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Logged In"),
              duration: Duration(seconds: 1),
            ),
          );
          await Navigator.pushNamed(context, MyRoutes.homeRoute);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Incorrect Password"),
              duration: Duration(seconds: 1),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User not found"),
            duration: Duration(seconds: 1),
          ),
        );
      }

      setState(() {
        tapButton = false;
      });
    }
  }

  moveToSignUp(BuildContext context) async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SignUpPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => Scaffold(
          backgroundColor: context.canvasColor,
          body: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 120.0,
              ),
              const Text(
                "Welcome to",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Mobify",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Rowdies"),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                  width: 250,
                ),
              ),
              const Text(
                "Please login to continue.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Enter Username",
                            labelText: "Username",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Enter Password",
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            } else if (value.length < 8) {
                              return "Password length should be atleast 8";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                            setState(() {});
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Material(
                        color: context.theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(tapButton ? 40 : 8),
                        child: InkWell(
                          onTap: () {
                            loadUsersData();
                            moveToHome(context);
                          },
                          child: AnimatedContainer(
                              width: tapButton ? 40 : 150,
                              height: 40,
                              alignment: Alignment.center,
                              duration: const Duration(seconds: 1),
                              child: tapButton
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          moveToSignUp(context);
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: context.theme.colorScheme.primary,
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          )),
    );
  }
}
