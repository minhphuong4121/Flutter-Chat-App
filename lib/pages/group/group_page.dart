import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/controller/group_controller.dart';
import 'package:flutter_my_chat_app/pages/group_chat/group_chat.dart';
import 'package:flutter_my_chat_app/pages/home/widget/chat_item.dart';
import 'package:get/get.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());

    return Obx(
      () => ListView(
        children: groupController.groupList
            .map(
              (group) => InkWell(
                onTap: () {
                  Get.to(GroupChatPage(groupModel: group));
                },
                child: ChatItem(
                  name: group.name!,
                  imageUrl: group.profileUrl == ""
                      ? AssetsImage.defaultProfileUrl
                      : group.profileUrl!,
                  lastChat: "Group Created",
                  lastTime: "Just now",
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
