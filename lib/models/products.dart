// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String description;
  final num price;
  final String color;
  final String imageURL;

  Product(this.id, this.name, this.description, this.price, this.color,
      this.imageURL);

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['id'] as int,
      map['name'] as String,
      map['description'] as String,
      map['price'] as num,
      map['color'] as String,
      map['imageURL'] as String,
    );
  }

  Product copyWith({
    int? id,
    String? name,
    String? description,
    num? price,
    String? color,
    String? imageURL,
  }) {
    return Product(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      price ?? this.price,
      color ?? this.color,
      imageURL ?? this.imageURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'color': color,
      'imageURL': imageURL,
    };
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, color: $color, imageURL: $imageURL)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.color == color &&
        other.imageURL == imageURL;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        color.hashCode ^
        imageURL.hashCode;
  }
}

class ProductModels {
 
  static List<Product> products = [];

  // get element by id
  static Product getById(int id) =>
      products.firstWhere((element) => element.id == id, orElse: null);

  // get element by position
  static Product getByPosition(int pos) => products[pos];
}
