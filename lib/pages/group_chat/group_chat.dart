import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/controller/group_controller.dart';
import 'package:flutter_my_chat_app/controller/profile_controller.dart';
import 'package:flutter_my_chat_app/model/group_model.dart';
import 'package:flutter_my_chat_app/pages/chat/widget/chat_bubble.dart';
import 'package:flutter_my_chat_app/pages/group/group_info/group_info.dart';
import 'package:flutter_my_chat_app/pages/group_chat/group_type_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupChatPage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupChatPage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            // Get.to(UserProfilePage(
            //   userModel: groupModel,
            // ));
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: groupModel.profileUrl == ""
                    ? AssetsImage.defaultProfileUrl
                    : groupModel.profileUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to((GroupInfo(
              groupModel: groupModel,
            )));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                groupModel.name ?? "group name",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "online",
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          )
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  StreamBuilder(
                      stream: groupController.getGroupMessages(groupModel.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        }
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("No messages"),
                          );
                        } else {
                          return ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                DateTime timeStamp = DateTime.parse(
                                    snapshot.data![index].timestamp!);
                                String formattedTime =
                                    DateFormat("hh:mm a").format(timeStamp);
                                return ChatBubble(
                                    message: snapshot.data![index].message!,
                                    isComing: snapshot.data![index].senderId !=
                                        profileController.currentUser.value.id,
                                    time: formattedTime,
                                    status: "read",
                                    imageUrl:
                                        snapshot.data![index].imageUrl ?? "");
                              });
                        }
                      }),
                  Obx(() => groupController.selectedImagePath.value != ""
                      ? Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(groupController
                                            .selectedImagePath.value),
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 300,
                              ),
                              Positioned(
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        groupController
                                            .selectedImagePath.value = "";
                                      },
                                      icon: const Icon(Icons.close))),
                            ],
                          ),
                        )
                      : const SizedBox()),
                ],
              ),
            ),
            GroupTypeMessage(groupModel: groupModel),
          ],
        ),
      ),
    );
  }
}
