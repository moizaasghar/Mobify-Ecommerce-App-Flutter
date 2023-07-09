import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../theme.dart';

class ProductImage extends StatelessWidget {
  final String image;
  const ProductImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(image)
        .box
        .rounded
        .p8
        .color(context.canvasColor)
        .make()
        .p16()
        .w40(context);
  }
}
