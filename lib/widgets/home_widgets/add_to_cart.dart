import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/products.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/store.dart';

class AddToCart extends StatelessWidget {
  final Product product;
  AddToCart({
    Key? key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);

    final CartModel _cart = (VxState.store as AppStore).cart;
    bool isInCart = _cart.items.contains(product) ? true : false;

    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            int quantity = 1; // Default quantity value

            return AlertDialog(
              title: const Text('Add to Cart'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Enter the quantity:'),
                  TextFormField(
                    initialValue: '1',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      quantity = int.tryParse(value) ?? 1;
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    AddMutation(product, quantity: quantity);
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(context.theme.colorScheme.primary),
          shape: MaterialStateProperty.all(const StadiumBorder())),
      child: isInCart
          ? const Icon(Icons.done)
          : Icon(CupertinoIcons.cart_badge_plus),
    );
  }
}
