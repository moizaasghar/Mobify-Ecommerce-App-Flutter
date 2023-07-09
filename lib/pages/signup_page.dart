import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/my_routes.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:velocity_x/velocity_x.dart';
import '../db/db-constant.dart';
import '../models/users.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name = "";
  String email = "";
  String phone = "";
  String password = "";

  bool tapButton = false;

  final _formKey = GlobalKey<FormState>();

    void moveToLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        tapButton = true;
      });

      final newUser = User(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      DBHelper.connect();
      final result = await DBHelper.insertUser(newUser.toMap());
      if (result == 'Success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User registered successfully'),
            duration: Duration(seconds: 1),
          ),
        );
        await Future.delayed(const Duration(seconds: 1));
        await Navigator.pushNamed(context, MyRoutes.loginRoute);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to register user'),
            duration: Duration(seconds: 1),
          ),
        );
      }

      setState(() {
        tapButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => Scaffold(
          backgroundColor: context.canvasColor,
          body: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 90.0,
              ),
              const Text(
                "Lets get started!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Create your account.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                "assets/images/signup.png",
                fit: BoxFit.cover,
                width: 250,
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
                            hintText: "Enter full name",
                            labelText: "Full Name",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Full name cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Enter Email",
                              labelText: "Email",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            } else if (value.contains("@") == false) {
                              return "Enter valid email";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                            setState(() {});
                          }),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter Phone Number",
                            labelText: "Phone Number",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone Number cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            phone = value;
                            setState(() {});
                          }),
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
                        height: 10.0,
                      ),
                      TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Enter Password Again",
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            } else if (value != password) {
                              return "Password does not match";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Material(
                          color: context.theme.colorScheme.primary,
                          borderRadius:
                              BorderRadius.circular(tapButton ? 40 : 8),
                          child: InkWell(
                            onTap: () => moveToLogin(context),
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
                                        "Sign Up",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )),
                          ),
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
