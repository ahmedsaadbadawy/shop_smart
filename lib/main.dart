import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';
import 'providers/theme_provider.dart';
import 'root_screen.dart';

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
          home: const RootScreen(),
        );
      }),
    );
  }
}
