import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/shopping_cart/domain/entities/entities.dart';

abstract class ShoppingCartRepository {
  Future<ShoppingCart> get();
  Future<ShoppingCart> add({required Product product, required int quantity});
  Future<ShoppingCart> clear();
}
