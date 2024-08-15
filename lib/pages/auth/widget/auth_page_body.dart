import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/pages/auth/widget/login_form.dart';
import 'package:flutter_my_chat_app/pages/auth/widget/signup_form.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AuthPageBody extends StatelessWidget {
  const AuthPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Expanded(
        child: Column(
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      isLogin.value = true;
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 2.5,
                      child: Column(
                        children: [
                          Text(
                            "Login",
                            style: isLogin.value
                                ? Theme.of(context).textTheme.bodyLarge
                                : Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          AnimatedContainer(
                            duration: const Duration(microseconds: 100),
                            width: isLogin.value ? 100 : 0,
                            height: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).colorScheme.primary),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      isLogin.value = false;
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 2.5,
                      child: Column(
                        children: [
                          Text(
                            "Signup",
                            style: isLogin.value
                                ? Theme.of(context).textTheme.labelLarge
                                : Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 100),
                            width: isLogin.value ? 0 : 100,
                            height: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).colorScheme.primary),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => isLogin.value ? const LoginForm() : const SignUpForm())
            
          ],
        ),
      ),
    );
  }
}
