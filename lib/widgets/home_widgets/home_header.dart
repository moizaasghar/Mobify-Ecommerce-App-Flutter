import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../theme.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Mobify".text.xl5.bold.color(context.accentColor).make(),
        "Trending Products".text.xl2.make(),
      ],
    );
  }
}
