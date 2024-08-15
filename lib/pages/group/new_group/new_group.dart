import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/controller/contact_controller.dart';
import 'package:flutter_my_chat_app/controller/group_controller.dart';
import 'package:flutter_my_chat_app/pages/group/new_group/group_title.dart';
import 'package:flutter_my_chat_app/pages/group/group_info/selected_member.dart';
import 'package:flutter_my_chat_app/pages/home/widget/chat_item.dart';
import 'package:get/get.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    GroupController groupController = Get.put(GroupController());

    return Scaffold(
        appBar: AppBar(
          title: const Text("New Group"),
        ),
        floatingActionButton: Obx(
          () => FloatingActionButton(
            backgroundColor: groupController.groupMembers.isEmpty ||
                    groupController.groupMembers == []
                ? Colors.grey
                : Theme.of(context).colorScheme.primary,
            onPressed: () {
              if (groupController.groupMembers.isEmpty) {
                Get.snackbar(
                  "Error",
                  "Please select at least one member!!!",
                );
              } else {
                //  Get.toNamed("/groupDetails");
                Get.to(GroupTitle());
              }
            },
            child: Icon(
              Icons.arrow_forward,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SelectedMember(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Contacts on Your Chat",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: contactController.getConTacts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  groupController
                                      .selectMember(snapshot.data![index]);
                                },
                                child: ChatItem(
                                  imageUrl:
                                      snapshot.data![index].profileImage ??
                                          AssetsImage.defaultProfileUrl,
                                  lastChat: snapshot.data![index].about ?? "",
                                  lastTime: "",
                                  name: snapshot.data![index].name,
                                ),
                              );
                            });
                      }
                    }),
              ),
            ],
          ),
        ));
  }
}
