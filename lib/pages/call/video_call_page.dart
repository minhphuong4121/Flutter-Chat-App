import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/string.dart';
import 'package:flutter_my_chat_app/controller/chat_controller.dart';
import 'package:flutter_my_chat_app/controller/profile_controller.dart';
import 'package:flutter_my_chat_app/model/user_model.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallPage extends StatelessWidget {
  final UserModel target;
  const VideoCallPage({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    var callId = chatController.getRoomId(target.id!);
    
    return ZegoUIKitPrebuiltCall(
      
      appID: ZegoCloudConfig.appId, // your AppID,
      appSign: ZegoCloudConfig.appSign,
      userID: profileController.currentUser.value.id!,
      userName: profileController.currentUser.value.name!,
      callID: callId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
