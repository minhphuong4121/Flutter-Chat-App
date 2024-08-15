import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/controller/group_controller.dart';
import 'package:flutter_my_chat_app/controller/image_picker.dart';
import 'package:flutter_my_chat_app/pages/home/widget/chat_item.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    RxBool isEdit = false.obs;
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = "".obs;
    RxString groupName = "".obs;
    TextEditingController groupNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Group"),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: groupName.isEmpty || groupName.value == ""
              ? Colors.grey
              : Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (groupName.isEmpty) {
              Get.snackbar(
                "Error",
                "Please enter Group name!!!",
              );
            } else {
              groupController.createGroup(groupName.value, imagePath.value);
            }
          },
          child: groupController.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Icon(
                  Icons.done,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primaryContainer),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Obx(
                        () => InkWell(
                          onTap: () async {
                            imagePath.value = await imagePickerController
                                .pickerImage(ImageSource.gallery);
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: imagePath.value == ""
                                ? const Icon(
                                    Icons.group,
                                    size: 40,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      File(imagePath.value),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          groupName.value = value;
                        },
                        decoration: const InputDecoration(
                            hintText: "Group name",
                            prefixIcon: Icon(Icons.group)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: groupController.groupMembers
                  .map((e) => ChatItem(
                        imageUrl:
                            e.profileImage ?? AssetsImage.defaultProfileUrl,
                        lastChat: e.about ?? "",
                        lastTime: "",
                        name: e.name!,
                      ))
                  .toList(),
            ),
          ))
        ],
      ),
    );
  }
}
