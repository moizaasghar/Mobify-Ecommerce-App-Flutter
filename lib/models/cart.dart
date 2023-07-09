import 'package:flutter_application_1/models/products.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/store.dart';

class CartModel {
  late ProductModels _product;

  final List<int> _itemIds = [];

  ProductModels get product => _product;

  set product(ProductModels newProduct) {
    assert(newProduct != null);
    _product = newProduct;
  }

  void clear() {
    _itemIds.clear();
  }

  List<Product> get items =>
      _itemIds.map((id) => ProductModels.getById(id)).toList();

  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  void add(Product product) {
    _itemIds.add(product.id);
  }

  void remove(Product product) {
    _itemIds.remove(product.id);
  }
}

class AddMutation extends VxMutation<AppStore> {
  final Product product;
  final int quantity;

  AddMutation(this.product, {this.quantity = 1});

  @override
  perform() {
    for (int i = 0; i < quantity; i++) {
      store?.cart._itemIds.add(product.id);
    }
  }
}

class RemoveMutation extends VxMutation<AppStore> {
  final Product product;

  RemoveMutation(this.product);

  @override
  perform() {
    store?.cart._itemIds.remove(product.id);
  }
}
