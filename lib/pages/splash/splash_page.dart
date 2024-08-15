import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/controller/splash_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    SplashController splashController = Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          AssetsImage.appIconSVG,
        ),
      ),
    );
  }
}
