import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/screens/inner_screens/viewed_recently.dart';
import 'consts/theme_data.dart';
import 'providers/theme_provider.dart';
import 'screens/auth/login.dart';
import 'screens/inner_screens/product_details.dart';
import 'screens/inner_screens/wishlist.dart';

void main() {
  runApp(const ShopSmart());
}

class ShopSmart extends StatelessWidget {
  const ShopSmart({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (
        context,
        themeProvider,
        child,
      ) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop Smart',
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          //home: const RootScreen(),
          home: const LoginScreen(),
          routes: {
            ProductDetails.routName: (context) => const ProductDetails(),
            WishlistScreen.routName: (context) => const WishlistScreen(),
            ViewedRecentlyScreen.routName: (context) => const ViewedRecentlyScreen(),
          },
        );
      }),
    );
  }
}
