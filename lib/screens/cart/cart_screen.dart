import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/providers/cart_provider.dart';
import 'package:shop_smart/services/my_app_method.dart';

import '../../consts/app_images.dart';
import '../../widgets/empty_bag.dart';
import '../../widgets/title_text.dart';
import 'bottom_checkout.dart';
import 'cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? const Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.imagesBagShoppingBasket,
              title: "Your cart is empty",
              subtitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            bottomSheet: const CartBottomCheckout(),
            appBar: AppBar(
              title: TitlesTextWidget(
                  label: "Cart (${cartProvider.getCartItems.length})"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.imagesBagShoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorORWarningDialog(
                      context: context,
                      subtitle: "Remove items",
                      fct: () => cartProvider.clearLocalCard(),
                      isError: false,
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: cartProvider.getCartItems.values
                            .toList()
                            .reversed
                            .toList()[index],
                        child: const CartWidget(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: kBottomNavigationBarHeight + 10),
              ],
            ),
          );
  }
}
