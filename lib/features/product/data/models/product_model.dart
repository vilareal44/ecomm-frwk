// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecomm/features/product/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.price,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
