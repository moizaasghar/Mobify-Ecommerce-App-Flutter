import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/products.dart';
import 'package:flutter_application_1/utilities/my_routes.dart';
import 'package:velocity_x/velocity_x.dart';
import '../core/store.dart';
import '../db/db-constant.dart';
import '../models/cart.dart';
import '../widgets/home_widgets/home_header.dart';
import '../widgets/home_widgets/product_list.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    var productJSON = await rootBundle.loadString("assets/files/products.json");
    final decodedJSON = jsonDecode(productJSON);
    final productsData = decodedJSON["products"];

    ProductModels.products = List.from(productsData)
        .map<Product>((product) => Product.fromMap(product))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as AppStore).cart;
    return Scaffold(
      floatingActionButton: VxBuilder(
        mutations: {AddMutation, RemoveMutation},
        builder: (context, _, __) => FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.cartRoute);
          },
          backgroundColor: context.theme.colorScheme.primary,
          child: const Icon(
            CupertinoIcons.cart,
            color: Colors.white,
          ),
        ).badge(
            color: Vx.red500,
            size: 20,
            count: _cart.items.length,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              if (ProductModels.products.isNotEmpty)
                const ProductList().py16().expand()
              else
                const CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
    );
  }
}
