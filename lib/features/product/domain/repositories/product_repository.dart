import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/features/product/domain/entities/entities.dart';

abstract class ProductRepository {
  Future<Product?> getById(String id);

  Future<List<Product>?> findAll();

  Future<List<Product>?> search(String query);
}
