import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/controller/chat_controller.dart';
import 'package:flutter_my_chat_app/controller/contact_controller.dart';
import 'package:flutter_my_chat_app/controller/profile_controller.dart';
import 'package:flutter_my_chat_app/pages/chat/chat_page.dart';
import 'package:flutter_my_chat_app/pages/contact/widget/contact_search.dart';
import 'package:flutter_my_chat_app/pages/contact/widget/new_contact_item.dart';
import 'package:flutter_my_chat_app/pages/group/new_group/new_group.dart';
import 'package:flutter_my_chat_app/pages/home/widget/chat_item.dart';
import 'package:get/get.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select contact"),
        actions: [
          Obx(() => IconButton(
              onPressed: () {
                isSearchEnable.value = !isSearchEnable.value;
              },
              icon: isSearchEnable.value
                  ? const Icon(Icons.close)
                  : const Icon(Icons.search)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              children: [
                Obx(
                  () => isSearchEnable.value
                      ? const ContactSearch()
                      : const SizedBox(),
                ),
                const SizedBox(
                  height: 10,
                ),
                NewContactItem(
                  btnName: "New contact",
                  icon: Icons.person_add,
                  onTap: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                NewContactItem(
                  btnName: "New group",
                  icon: Icons.group_add,
                  onTap: () {
                    Get.to(NewGroup());
                  },
                ),
              ],
            ),
            const Row(
              children: [
                Text("Contacts on Your Chat"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => Expanded(
                child: ListView(
                  children: contactController.userList
                      .map(
                        (e) => InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            //Get.toNamed("/chatPage", arguments: e);
                            Get.to(ChatPage(userModel: e));
                          },
                          child: ChatItem(
                            imageUrl:
                                e.profileImage ?? AssetsImage.defaultProfileUrl,
                            name: e.name ?? "User name",
                            lastChat: e.about ?? "Hello",
                            lastTime: e.email ==
                                    profileController.currentUser.value.email
                                ? "You"
                                : "",
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
