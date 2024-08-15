import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/model/group_model.dart';
import 'package:flutter_my_chat_app/pages/group/group_info/group_member_info.dart';
import 'package:flutter_my_chat_app/pages/home/widget/chat_item.dart';

class GroupInfo extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInfo({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupModel.name!),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            GroupMemberInfo(
                groupId: groupModel.id!,
                profileImage: groupModel.profileUrl == ""
                    ? AssetsImage.defaultProfileUrl
                    : groupModel.profileUrl!,
                userName: groupModel.name!,
                userEmail: groupModel.description ?? "No info"),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Members",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: groupModel.members!
                  .map((member) => ChatItem(
                        imageUrl: member.profileImage ??
                            AssetsImage.defaultProfileUrl,
                        name: member.name!,
                        lastChat: member.email,
                        lastTime: member.role == "admin" ? "Admin" : "Member",
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
