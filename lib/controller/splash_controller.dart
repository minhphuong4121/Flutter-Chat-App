import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    super.onInit();
    await splashHandle();
  }

  Future<void> splashHandle() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (auth.currentUser == null) {
      Get.offAllNamed("/authPage");
    } else {
      Get.offAllNamed("/homePage");
      print(auth.currentUser!.email);
    }
  }
}
