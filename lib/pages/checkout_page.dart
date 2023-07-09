import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/my_routes.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:velocity_x/velocity_x.dart';
import '../core/store.dart';
import '../db/db-constant.dart';
import '../models/cart.dart';
import '../models/order.dart';
import '../models/users.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String address = "";
  String email = "";

  bool tapButton = false;

  final _formKey = GlobalKey<FormState>();

  void moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        tapButton = true;
      });

      var _id = DateTime.now().millisecondsSinceEpoch.toString();

      final newOrder = Order(
        address: address,
        customerName: email,
        products: (VxState.store as AppStore).cart.items,
        id: _id,
      );

      DBHelper.connect();
      final result = await DBHelper.insertOrder(newOrder.toMap());
      if (result == 'Success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Order Placed successfully'),
            duration: Duration(seconds: 1),
          ),
        );
        await Future.delayed(const Duration(seconds: 1));
        await Navigator.pushNamed(context, MyRoutes.homeRoute);

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to place order'),
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
    final CartModel _cart = (VxState.store as AppStore).cart;
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => Scaffold(
          backgroundColor: context.canvasColor,
          body: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 90.0,
              ),
              const Text(
                "Few Steps Away!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Place your order.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // add order summary here
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Order Total",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                  height: 70,
                  child: VxConsumer(
                      mutations: {RemoveMutation},
                      builder: (context, _, status) {
                        return "\$${_cart.totalPrice}"
                            .text
                            .xl5
                            .color(context.accentColor)
                            .make();
                      })),
              Image.asset(
                "assets/images/Cart.png",
                height: 200,
                width: 200,
              ).centered(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Enter your email",
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
                            hintText: "Enter your address for delivery",
                            labelText: "Address",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_on),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Address cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            address = value;
                            setState(() {});
                          }),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          hintText: "Select Payment Method",
                          labelText: "Payment Method",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.payment),
                        ),
                        items: const [
                          DropdownMenuItem(
                            child: Text("Cash on Delivery"),
                            value: "Cash on Delivery",
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
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
                            onTap: () => moveToHome(context),
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
                                        "Place Order",
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
