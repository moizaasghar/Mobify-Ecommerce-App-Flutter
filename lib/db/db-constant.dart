import 'dart:developer';

import 'package:flutter_application_1/models/order.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DBHelper {
  static const mogoURI = ""; //  add your url here

  static const String PRODUCT_COLLECTION = 'products';
  static const String USER_COLLECTION = 'users';
  static const String ORDER_COLLECTION = 'orders';

  static var productCollection;
  static var userCollection;
  static var orderCollection;

  static connect() async {
    try {
      var db = await Db.create(mogoURI);
      await db.open();
      log('DB Connected');
      inspect(db);
      productCollection = db.collection(PRODUCT_COLLECTION);
      userCollection = db.collection(USER_COLLECTION);
      orderCollection = db.collection(ORDER_COLLECTION);
    } catch (e) {
      log('DB Connection Error: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final userData = await userCollection.find().toList();
    log('User Data: $userData');
    return userData;
  }

  static Future<String> insertUser(Map<String, dynamic> user) async {
    try {
      final result = await userCollection.insertOne(user);
      log('User Inserted: $result');
      return 'Success';
    } catch (e) {
      log('User Insertion Error: $e');
      return 'Error';
    }
  }

  static Future<String> insertOrder(Map<String, dynamic> order) async {
    try {
      final result = await orderCollection.insertOne(order);
      log('User Inserted: $result');
      return 'Success';
    } catch (e) {
      log('User Insertion Error: $e');
      return 'Error';
    }
  }
}
