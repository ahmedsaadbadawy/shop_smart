import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/models/product_model.dart';
import 'package:shop_smart/providers/viewed_prod_provider.dart';
import '../../providers/cart_provider.dart';
import '../../services/my_app_method.dart';
import '/widgets/subtitle_text.dart';

import '../../screens/inner_screens/product_details.dart';
import 'heart_btn.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productModel = Provider.of<ProductModel>(context);
    final viewedProvider = Provider.of<ViewedProdProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProvider.addProductToHistory(productId: productModel.productId);
          await Navigator.pushNamed(
            context,
            ProductDetails.routName,
            arguments: productModel.productId,
          );
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: productModel.productImage,
                    width: size.width * 0.28,
                    height: size.width * 0.28,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          HeartButtonWidget(productId: productModel.productId),
                          IconButton(
                            onPressed: () async {
                              if (cartProvider.isProductInCart(
                                  productId: productModel.productId)) {
                                return;
                              }
                              // cartProvider.addProductToCart(
                              //   productId: getCurrProduct.productId,
                              // );
                              try {
                                await cartProvider.addToCartFirebase(
                                    productId: productModel.productId,
                                    qty: 1,
                                    context: context);
                              } catch (error) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  MyAppMethods.showErrorORWarningDialog(
                                    context: context,
                                    subtitle: error.toString(),
                                    fct: () {},
                                  );
                                });
                              }
                            },
                            icon: Icon(
                              cartProvider.isProductInCart(
                                      productId: productModel.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_rounded,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SubtitleTextWidget(
                        label: "${productModel.productPrice}\$",
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
