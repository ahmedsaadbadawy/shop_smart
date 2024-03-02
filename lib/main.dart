import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'utils/providers/theme_provider.dart';
import 'utils/theme_data.dart';

void main() {
  runApp(const ShopSmart());
}

class ShopSmart extends StatelessWidget {
  const ShopSmart({super.key});

  // This widget is the root of your application.
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
          title: 'Shop Smart',
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const HomeScreen(),
        );
      }),
    );
  }
}
