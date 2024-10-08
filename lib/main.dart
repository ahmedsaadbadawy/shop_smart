import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/firebase_options.dart';
import 'package:shop_smart/providers/product_provider.dart';
import 'package:shop_smart/providers/user_provider.dart';
import 'package:shop_smart/providers/viewed_prod_provider.dart';
import 'package:shop_smart/providers/wishlist_provider.dart';
import 'package:shop_smart/screens/auth/register.dart';
import 'package:shop_smart/screens/inner_screens/viewed_recently.dart';
import 'package:shop_smart/screens/search_screen.dart';
import 'consts/theme_data.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/theme_provider.dart';
import 'root_screen.dart';
import 'screens/auth/forgot_password.dart';
import 'screens/auth/login.dart';
import 'screens/inner_screens/orders/orders_screen.dart';
import 'screens/inner_screens/product_details.dart';
import 'screens/inner_screens/wishlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewedProdProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
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
          home: const RootScreen(),
          routes: {
            ProductDetails.routName: (context) => const ProductDetails(),
            WishlistScreen.routName: (context) => const WishlistScreen(),
            ViewedRecentlyScreen.routName: (context) =>
                const ViewedRecentlyScreen(),
            RegisterScreen.routName: (context) => const RegisterScreen(),
            LoginScreen.routName: (context) => const LoginScreen(),
            OrdersScreenFree.routName: (context) => const OrdersScreenFree(),
            ForgotPasswordScreen.routName: (context) =>
                const ForgotPasswordScreen(),
            SearchScreen.routName: (context) => const SearchScreen(),
            RootScreen.routName: (context) => const RootScreen(),
          },
        );
      }),
    );
  }
}
