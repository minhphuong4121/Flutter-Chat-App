import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/controller/auth_controller.dart';
import 'package:flutter_my_chat_app/utils/widget/primary_button.dart';
import 'package:get/get.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    pwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: "Full Name",
            prefixIcon: Icon(Icons.person_2_outlined),
          ),
        ),
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
                      btnName: "SIGN UP",
                      icon: Icons.login_outlined,
                      onTap: () {
                        authController.crateUser(emailController.text,
                            pwdController.text, nameController.text);
                      },
                    ),
                  ],
                ),
        )
      ],
    );
  }
}
