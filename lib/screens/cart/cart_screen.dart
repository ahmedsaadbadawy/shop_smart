import 'package:flutter/material.dart';

import '../../consts/app_images.dart';
import '../../widgets/empty_bag.dart';
import '../../widgets/title_text.dart';
import 'cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return isEmpty
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
            appBar: AppBar(
              title: const TitlesTextWidget(label: "Cart (5)"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.imagesBagShoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return const CartWidget();
              },
            ),
          );
  }
}
