import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/screens/auth/login.dart';
import 'package:shop_smart/screens/inner_screens/orders/orders_screen.dart';
import 'package:shop_smart/screens/inner_screens/viewed_recently.dart';
import '../consts/app_images.dart';
import '../providers/theme_provider.dart';
import '../services/my_app_method.dart';
import '../widgets/app_name_text.dart';
import '../widgets/subtitle_text.dart';
import '../widgets/title_text.dart';
import 'inner_screens/wishlist.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const AppNameTextWidget(fontSize: 20),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.imagesBagShoppingCart),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: TitlesTextWidget(
                    label: "Please login to have ultimate access"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.background,
                          width: 3),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitlesTextWidget(label: "Ahmed Saad"),
                      SubtitleTextWidget(label: "ahmedsaad@gmail.com"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitlesTextWidget(label: "General"),
                  CustomListTile(
                    imagePath: AssetsManager.imagesBagOrderSvg,
                    text: "All orders",
                    function: () async {
                      await Navigator.pushNamed(
                        context,
                        OrdersScreenFree.routName,
                      );
                    },
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.imagesBagWishlistSvg,
                    text: "Wishlist",
                    function: () async {
                      await Navigator.pushNamed(
                          context, WishlistScreen.routName);
                    },
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.imagesProfileRecent,
                    text: "Viewed recently",
                    function: () async {
                      await Navigator.pushNamed(
                          context, ViewedRecentlyScreen.routName);
                    },
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.imagesProfileAddress,
                    text: "Address",
                    function: () {},
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const TitlesTextWidget(label: "Settings"),
                  const SizedBox(
                    height: 7,
                  ),
                  SwitchListTile(
                    secondary: Image.asset(
                      AssetsManager.imagesProfileTheme,
                      height: 30,
                    ),
                    title: Text(themeProvider.getIsDarkTheme
                        ? "Dark mode"
                        : "Light mode"),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                ),
                onPressed: () async {
                  if (user == null) {
                    await Navigator.pushNamed(context, LoginScreen.routName);
                  } else {
                    await MyAppMethods.showErrorORWarningDialog(
                      context: context,
                      subtitle: "Are you sure?",
                      fct: () async {
                        await FirebaseAuth.instance.signOut();
                        WidgetsBinding.instance.addPostFrameCallback((_) async {
                          await Navigator.pushNamed(
                              context, LoginScreen.routName);
                        });
                      },
                      isError: false,
                    );
                  }
                },
                icon: user == null
                    ? const Icon(Icons.login, color: Colors.white)
                    : const Icon(Icons.logout, color: Colors.white),
                label: Text(
                  user == null ? "Login" : "Sign up",
                  selectionColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.function});
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(
        imagePath,
        height: 30,
      ),
      title: SubtitleTextWidget(label: text),
      trailing: const Icon(IconlyLight.arrow_right_2),
    );
  }
}
