import 'package:flutter/material.dart';

import '../models/products.dart';

class ItemWidget extends StatelessWidget {
  final Product product;

  const ItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: Image.asset(product.imageURL),
        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: Text(
          "\$${product.price}",
          textScaleFactor: 1.5,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
