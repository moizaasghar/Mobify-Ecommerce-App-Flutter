import 'package:flutter/material.dart';
import '../../models/cart.dart';
import '../../models/products.dart';
import '../../pages/product_detail_page.dart';
import '../theme.dart';
import 'package:velocity_x/velocity_x.dart';

import 'add_to_cart.dart';
import 'product_image.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ProductModels.products.length,
      itemBuilder: (context, index) {
        final product = ProductModels.products[index];
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product))),
          child: ProductItem(
            product: product,
          ),
        );
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    
    return VxBox(
        child: Row(
      children: [
        Hero(
          tag: Key(product.id.toString()),
          child: ProductImage(image: product.imageURL,),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            product.name.text.lg.color(context.accentColor).bold.make(),
            product.description.text.textStyle(context.captionStyle!).make(),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                "\$${product.price}".text.bold.xl.make(),
                AddToCart(product: product)
              ],
            ).pOnly(right: 8.0)
          ],
        ))
      ],
    )).color(context.cardColor).rounded.square(150).make().py16();
  }
}
