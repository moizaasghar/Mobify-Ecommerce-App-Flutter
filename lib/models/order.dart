import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/products.dart';

class Order {
  final String id;
  final String customerName;
  final String address;
  final List<Product> products;
  
  Order({
    required this.id,
    required this.customerName,
    required this.address,
    required this.products,
  });

  Order copyWith({
    String? id,
    String? customerName,
    String? address,
    List<Product>? products,
  }) {
    return Order(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      address: address ?? this.address,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerName': customerName,
      'address': address,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      customerName: map['customerName'] as String,
      address: map['address'] as String,
      products: List<Product>.from((map['products'] as List<int>).map<Product>((x) => Product.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, customerName: $customerName, address: $address, products: $products)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.customerName == customerName &&
      other.address == address &&
      listEquals(other.products, products);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      customerName.hashCode ^
      address.hashCode ^
      products.hashCode;
  }
}

