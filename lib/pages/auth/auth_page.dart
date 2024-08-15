import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/config/string.dart';
import 'package:flutter_my_chat_app/pages/auth/widget/auth_page_body.dart';
import 'package:flutter_svg/svg.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset(
                    AssetsImage.appIconSVG,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ]),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  AppString.appName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  height: 30,
                ),
                const AuthPageBody()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
