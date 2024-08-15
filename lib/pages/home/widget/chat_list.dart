import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/controller/contact_controller.dart';
import 'package:flutter_my_chat_app/controller/profile_controller.dart';
import 'package:flutter_my_chat_app/pages/chat/chat_page.dart';
import 'package:flutter_my_chat_app/pages/home/widget/chat_item.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());

    return RefreshIndicator(
        child: Obx(() => ListView(
              children: contactController.chatRoomList
                  .map(
                    (e) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          // Get.toNamed("/chatPage");
                          Get.to(
                            ChatPage(
                              userModel: (e.receiver!.id ==
                                      profileController.currentUser.value.id
                                  ? e.sender
                                  : e.receiver)!,
                            ),
                          );
                        },
                        child: ChatItem(
                          imageUrl: (e.receiver!.id ==
                                      profileController.currentUser.value.id
                                  ? e.sender!.profileImage
                                  : e.receiver!.profileImage) ??
                              AssetsImage.defaultProfileUrl,
                          name: (e.receiver!.id ==
                                      profileController.currentUser.value.id
                                  ? e.sender!.name
                                  : e.receiver!.name) ??
                              "Receiver name",
                          lastChat: e.lastMessage ?? "last message",
                          lastTime: e.lastMessageTimestamp ?? " Last time",
                        )),
                  )
                  .toList(),
            )),
        onRefresh: () {
          return contactController.getChatRoomList();
        });
  }
}
