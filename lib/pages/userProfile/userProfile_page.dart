import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/controller/auth_controller.dart';
import 'package:flutter_my_chat_app/controller/profile_controller.dart';
import 'package:flutter_my_chat_app/model/user_model.dart';
import 'package:flutter_my_chat_app/pages/userProfile/widget/user_info.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  final UserModel userModel;
  const UserProfilePage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: [
            IconButton(
              onPressed: () {
                //Get.toNamed("/updateProfilePage");
              },
              icon: Icon(Icons.edit),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              LoginUserInfo(
                profileImage:
                    userModel.profileImage ?? AssetsImage.defaultProfileUrl,
                userEmail: userModel.email ?? "User Name",
                userName: userModel.name ?? "",
              ),
            ],
          ),
        ));
  }
}
