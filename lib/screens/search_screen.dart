import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/providers/product_provider.dart';

import '../consts/app_images.dart';
import '../models/product_model.dart';
import '../widgets/title_text.dart';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

import '../widgets/products/product_widget.dart';

class SearchScreen extends StatefulWidget {
  static const routName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    String? passedCategory = ModalRoute.of(context)!.settings.arguments as String?;

    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(ctgName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title:  TitlesTextWidget(label: passedCategory?? "Search"),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsManager.imagesBagShoppingCart),
            ),
          ),
          body: productList.isEmpty? const Center(
            child: TitlesTextWidget(label: "No product found"),
          ): Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        searchTextController.clear();
                        FocusScope.of(context).unfocus();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  onChanged: (value) {},
                  onSubmitted: (value) {
                    log(searchTextController.text);
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: DynamicHeightGridView(
                    itemCount: productList.length,
                    builder: ((context, index) {
                      return ChangeNotifierProvider.value(
                        value: productList[index],
                        child: ProductWidget(
                          productId:
                              productList[index].productId,
                        ),
                      );
                    }),
                    crossAxisCount: 2,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
