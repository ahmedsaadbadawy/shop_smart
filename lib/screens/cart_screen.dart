import 'package:flutter/material.dart';

import '../consts/app_images.dart';
import '../widgets/empty_bag.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EmptyBagWidget(
        imagePath: AssetsManager.imagesBagShoppingBasket,
        title: "Your cart is empty",
        subtitle:
            'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
        buttonText: "Shop Now",
      ),
    );
  }
}
