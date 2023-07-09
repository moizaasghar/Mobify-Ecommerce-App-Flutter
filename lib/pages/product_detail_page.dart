import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/products.dart';
import 'package:flutter_application_1/widgets/home_widgets/add_to_cart.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "\$${product.price}"
                .text
                .bold
                .xl4
                .color(context.accentColor)
                .make(),
            AddToCart(product: product)
          ],
        ).pOnly(right: 8.0).p32(),
      ),
      appBar: AppBar(
        backgroundColor: context.canvasColor,
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(product.id.toString()),
              child: Image.asset(product.imageURL),
            ).h32(context),
            Expanded(
                child: VxArc(
                    height: 30.0,
                    arcType: VxArcType.convey,
                    edge: VxEdge.top,
                    child: Container(
                      color: context.cardColor,
                      width: context.screenWidth,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 64.0, left: 12, right: 12),
                          child: Column(children: [
                            product.name.text.xl4
                                .color(context.accentColor)
                                .bold
                                .align(TextAlign.center)
                                .make(),
                            product.description.text.xl
                                .textStyle(context.captionStyle!)
                                .align(TextAlign.center)
                                .make(),
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam consequat fringilla risus, vel ultrices lorem commodo nec. Quisque eu magna rutrum, posuere justo sit amet, pharetra purus. Duis lacinia finibus massa, sed dictum sem cursus non. Aliquam erat volutpat. Sed eu tortor sed urna dapibus semper sed vitae magna. Integer vulputate ultricies tellus, non scelerisque ipsum tempus id."
                                .text
                                .textStyle(context.captionStyle!)
                                .align(TextAlign.center)
                                .make()
                                .p16(),
                          ]),
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
