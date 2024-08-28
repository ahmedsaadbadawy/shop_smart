import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';

import '../../root_screen.dart';
import '../../services/my_app_method.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSignIn({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
              await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            ),
          );

          if (context.mounted) {
            Navigator.pushReplacementNamed(context, RootScreen.routName);
          }
        } on FirebaseException catch (e) {
          log("message");
          // instead of the "mounted bool".
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            MyAppMethods.showErrorORWarningDialog(
              context: context,
              subtitle: "An error has been occured ${e.message}",
              fct: () {},
            );
          });
        } catch (e) {
          log("message");
          if (context.mounted) {
            // instead of the "mounted bool".
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              MyAppMethods.showErrorORWarningDialog(
                context: context,
                subtitle: "An error has been occured $e",
                fct: () {},
              );
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
      icon: const Icon(
        Ionicons.logo_google,
        color: Colors.red,
      ),
      label: const Text(
        "Sign in with google",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      onPressed: () async {
        await _googleSignIn(context: context);
      },
    );
  }
}
