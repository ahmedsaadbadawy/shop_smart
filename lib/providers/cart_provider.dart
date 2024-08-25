import 'package:flutter/material.dart';
import 'package:shop_smart/models/cart_model.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItem = {};

  Map<String, CartModel> get getCartItem {
    return _cartItem;
  }

  void addProductToCart({required String productId}) {
    //  "Map.putIfAbsent" => Look up the value of [key], or add a new entry if it isn't there.
    getCartItem.putIfAbsent(
      productId,
      () => CartModel(
        cartId: const Uuid().v4(),
        productId: productId,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  bool isProductInCart({required String productId}) {
    return _cartItem.containsKey(productId);
  }
}
