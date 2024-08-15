import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/controller/chat_controller.dart';
import 'package:flutter_my_chat_app/controller/group_controller.dart';
import 'package:flutter_my_chat_app/controller/image_picker.dart';
import 'package:flutter_my_chat_app/controller/profile_controller.dart';
import 'package:flutter_my_chat_app/model/group_model.dart';
import 'package:flutter_my_chat_app/model/user_model.dart';
import 'package:flutter_my_chat_app/utils/widget/image_picker_bottom_sheet.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GroupTypeMessage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupTypeMessage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    GroupController groupController = Get.put(GroupController());

    return Container(
      //margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Obx(
            () => groupController.selectedImagePath.value == ""
                ? InkWell(
                    onTap: () {
                      imagePickerBottomSheet(
                          context,
                          groupController.selectedImagePath,
                          imagePickerController);
                    },
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        AssetsImage.chatGallery,
                        width: 25,
                        colorFilter: const ColorFilter.mode(
                            Colors.grey, BlendMode.srcIn),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                message.value = value;
              },
              controller: messageController,
              decoration: const InputDecoration(
                filled: false,
                hintText: "Type message ...",
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.emoji_emotions,
                size: 30,
                color: Color.fromARGB(255, 202, 202, 98),
              )),
          const SizedBox(
            width: 20,
          ),
          Obx(() => message.value != "" ||
                  groupController.selectedImagePath.value != ""
              ? InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    groupController.sendGrouPMessage(
                      messageController.text,
                      groupModel.id!,
                      "",
                    );

                    messageController.clear();
                    message.value = "";
                    // if (messageController.text.isNotEmpty ||
                    //     chatController.selectedImagePath.value.isNotEmpty) {
                    //   chatController.sendMessage(
                    //       groupModel.id!, messageController.text, groupModel);
                    //
                    // }
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: groupController.isLoading.value
                        ? const CircularProgressIndicator()
                        : SvgPicture.asset(
                            AssetsImage.chatSend,
                            width: 20,
                            colorFilter: const ColorFilter.mode(
                                Colors.grey, BlendMode.srcIn),
                          ),
                  ))
              : SizedBox(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    AssetsImage.chatMic,
                    colorFilter:
                        const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                    width: 25,
                  ),
                ))
        ],
      ),
    );
  }
}
