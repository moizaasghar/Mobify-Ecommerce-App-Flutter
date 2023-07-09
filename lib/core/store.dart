import 'package:flutter_application_1/models/products.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/cart.dart';
import '../models/users.dart';

class AppStore extends VxStore {
  late ProductModels products;
  late CartModel cart;
  late UserModel user;

  AppStore() {
    products = ProductModels();
    user = UserModel();
    cart = CartModel();
    cart.product = products;
  }
}