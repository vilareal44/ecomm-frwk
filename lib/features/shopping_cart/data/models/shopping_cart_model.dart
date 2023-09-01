// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecomm/features/shopping_cart/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

import 'shopping_cart_line_item_model.dart';

class ShoppingCartModel extends ShoppingCart {
  const ShoppingCartModel({
    super.lineItems = const [],
  });

  @override
  List<Object> get props => [lineItems];

  ShoppingCartModel copyWith({
    List<ShoppingCartLineItemModel>? lineItems,
  }) {
    return ShoppingCartModel(
      lineItems: lineItems ?? this.lineItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lineItems': lineItems.map((x) => x.toMap()).toList(),
    };
  }

  factory ShoppingCartModel.fromMap(Map<String, dynamic> map) {
    return ShoppingCartModel(
      lineItems: List<ShoppingCartLineItemModel>.from(
        (map['lineItems'] as List<dynamic>).map<ShoppingCartLineItemModel>(
          (x) => ShoppingCartLineItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingCartModel.fromJson(String source) =>
      ShoppingCartModel.fromMap(json.decode(source));
}
