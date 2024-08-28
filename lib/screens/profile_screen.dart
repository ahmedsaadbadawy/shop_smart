import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/screens/auth/login.dart';
import 'package:shop_smart/screens/inner_screens/loading_manager.dart';
import 'package:shop_smart/screens/inner_screens/orders/orders_screen.dart';
import 'package:shop_smart/screens/inner_screens/viewed_recently.dart';
import '../consts/app_images.dart';
import '../models/user_model.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
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
  bool _isLoading = true;
  UserModel? userModel;

  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      log("message");
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
      log("Done");
    } catch (error) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: "An error has been occured $error",
          fct: () {},
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

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
        body: LoadingManager(
          isLoading: _isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: user == null ? true : false,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TitlesTextWidget(
                      label: "Please login to have ultimate access"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              userModel == null
                  ? const SizedBox.shrink()
                  : Padding(
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
                                  color: Theme.of(context).colorScheme.surface,
                                  width: 3),
                              image: DecorationImage(
                                image: NetworkImage(
                                  userModel?.userImage == null
                                      ? userModel!.userImage
                                      : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitlesTextWidget(label: userModel!.userName),
                              SubtitleTextWidget(label: userModel!.userEmail),
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
                    user == null
                        ? const SizedBox.shrink()
                        : CustomListTile(
                            imagePath: AssetsManager.imagesBagOrderSvg,
                            text: "All orders",
                            function: () async {
                              await Navigator.pushNamed(
                                context,
                                OrdersScreenFree.routName,
                              );
                            },
                          ),
                    user == null
                        ? const SizedBox.shrink()
                        : CustomListTile(
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
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) async {
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
          ),
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
