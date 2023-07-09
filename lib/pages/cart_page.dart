import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/theme.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/store.dart';
import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Cart".text.color(context.accentColor).make(),
        iconTheme: IconThemeData(color: context.accentColor),
        backgroundColor: context.canvasColor,
      ),
      backgroundColor: context.canvasColor,
      body: Column(
        children: [
          CartList().p32().expand(),
          Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as AppStore).cart;

    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxConsumer(
              mutations: {RemoveMutation},
              builder: (context, _, status) {
                return "\$${_cart.totalPrice}"
                    .text
                    .xl5
                    .color(context.accentColor)
                    .make();
              }),
          30.widthBox,
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/checkout");
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    context.theme.colorScheme.secondary)),
            child: "Buy".text.make(),
          ).w32(context)
        ],
      ),
    );
  }
}

class CartList extends StatelessWidget {
  CartList({super.key});

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel _cart = (VxState.store as AppStore).cart;

    return _cart.items.isEmpty
        ? "Cart is Empty".text.xl3.make().centered()
        : ListView.builder(
            itemCount: _cart.items.length,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(Icons.done),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  RemoveMutation(_cart.items[index]);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: "Item removed from cart".text.make()));
                },
              ),
              title: _cart.items[index].name.text.make(),
            ),
          );
  }
}
