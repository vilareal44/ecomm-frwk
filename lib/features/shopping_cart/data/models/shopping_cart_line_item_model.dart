import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:ecomm/features/product/data/models/product_model.dart';
import 'package:ecomm/features/shopping_cart/domain/entities/entities.dart';

class ShoppingCartLineItemModel extends ShoppingCartLineItem {
  const ShoppingCartLineItemModel({
    required super.product,
    required super.quantity,
  });

  ShoppingCartLineItemModel copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return ShoppingCartLineItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory ShoppingCartLineItemModel.fromMap(Map<String, dynamic> map) {
    return ShoppingCartLineItemModel(
      product: ProductModel.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingCartLineItemModel.fromJson(String source) =>
      ShoppingCartLineItemModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
