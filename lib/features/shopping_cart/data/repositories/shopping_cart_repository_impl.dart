import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/shopping_cart/domain/repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/shopping_cart_line_item_model.dart';
import '../models/shopping_cart_model.dart';

class ShoppingCartRepositoryImpl implements ShoppingCartRepository {
  ShoppingCartRepositoryImpl(SharedPreferences prefs) {
    final String? cartSerialized = prefs.getString(prefKey);

    if (cartSerialized == null) {
      _cart = const ShoppingCartModel();
    } else {
      _cart = ShoppingCartModel.fromJson(cartSerialized);
    }

    _prefs = prefs;
  }

  late ShoppingCartModel _cart;
  late SharedPreferences _prefs;
  static const prefKey = 'shopping_cart_serialized';

  @override
  Future<ShoppingCartModel> add({
    required Product product,
    required int quantity,
  }) async {
    _cart = ShoppingCartModel(
      lineItems: List.from(
        [
          ..._cart.lineItems,
          ShoppingCartLineItemModel(product: product, quantity: quantity)
        ],
      ),
    );

    await _prefs.setString(prefKey, _cart.toJson());

    return _cart;
  }

  @override
  Future<ShoppingCartModel> get() async {
    return _cart;
  }

  @override
  Future<ShoppingCartModel> clear() async {
    _cart = const ShoppingCartModel();
    await _prefs.remove(prefKey);
    return _cart;
  }
}
