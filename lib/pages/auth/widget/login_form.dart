import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/controller/auth_controller.dart';
import 'package:flutter_my_chat_app/utils/widget/primary_button.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    pwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
              hintText: "Email", prefixIcon: Icon(Icons.email_outlined)),
        ),
        const SizedBox(
          height: 40,
        ),
        TextField(
          controller: pwdController,
          decoration: const InputDecoration(
              hintText: "Password", prefixIcon: Icon(Icons.lock_outline)),
        ),
        const SizedBox(
          height: 60,
        ),
        Obx(
          () => authController.isLoading.value
              ? const CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                      onTap: () {
                        authController.login(
                          emailController.text,
                          pwdController.text,
                        );
                        //Get.offAllNamed("/homePage");
                      },
                    ),
                  ],
                ),
        )
      ],
    );
  }
}
