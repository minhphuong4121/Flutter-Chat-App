import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/config/string.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsImage.appIconSVG,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppString.appName,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SlideAction(
              onSubmit: () {
                Get.offAllNamed("/authPage");
              },
              sliderButtonIcon: const Icon(
                Icons.swipe_right_outlined,
              ),
              sliderRotate: false,
              text: "Slide to start now",
              textStyle: Theme.of(context).textTheme.labelLarge,
              innerColor: Theme.of(context).colorScheme.primary,
              outerColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
