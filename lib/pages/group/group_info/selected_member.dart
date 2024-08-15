import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/controller/group_controller.dart';
import 'package:get/get.dart';

class SelectedMember extends StatelessWidget {
  const SelectedMember({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Obx(
      () => Row(
          children: groupController.groupMembers
              .map((e) => Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl:
                                e.profileImage ?? AssetsImage.defaultProfileUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            groupController.groupMembers.remove(e);
                          },
                          highlightColor: Colors.transparent,
                          child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 15,
                              )),
                        ),
                      )
                    ],
                  ))
              .toList()),
    );
  }
}
