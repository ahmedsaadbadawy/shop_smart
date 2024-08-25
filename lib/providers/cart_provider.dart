import 'package:flutter/material.dart';
import 'package:shop_smart/models/cart_model.dart';
import 'package:shop_smart/providers/product_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  void addProductToCart({required String productId}) {
    //  "Map.putIfAbsent" => Look up the value of [key], or add a new entry if it isn't there.
    getCartItems.putIfAbsent(
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
    return _cartItems.containsKey(productId);
  }

  void updateQuantity({required String productId, required int quantity}) {
    getCartItems.update(
      productId,
      (item) => CartModel(
        cartId: item.cartId,
        productId: productId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }

  double getTotal({required ProductProvider productProvider}) {
    double total = 0.0;
    _cartItems.forEach(
      (key, value) {
        final ProductModel? getCurrProduct =
            productProvider.findByProdId(value.productId);
        if (getCurrProduct != null) {
          total += double.parse(getCurrProduct.productPrice) * value.quantity;
        }
      },
    );
    return total;
  }

  int getQty() {
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  void removeOneItem({required String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearLocalCard() {
    _cartItems.clear();
    notifyListeners();
  }
}
