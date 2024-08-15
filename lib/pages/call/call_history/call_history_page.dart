import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/config/images.dart';
import 'package:flutter_my_chat_app/controller/chat_controller.dart';
import 'package:flutter_my_chat_app/pages/home/widget/chat_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CallHistoryPage extends StatelessWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    return StreamBuilder(
        stream: chatController.getCalls(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  DateTime timestamp =
                      DateTime.parse(snapshot.data![index].timestamp!);
                  String formattedTime =
                      DateFormat("hh:mm a").format(timestamp);

                  return ChatItem(
                    imageUrl: snapshot.data![index].receiverPic ??
                        AssetsImage.defaultProfileUrl,
                    name: snapshot.data![index].receiverName ?? "",
                    lastChat: snapshot.data![index].type ?? "",
                    lastTime: formattedTime,
                  );
                });
          } else {
            return Center(
                child: Container(
                    width: 200,
                    height: 200,
                    child: const CircularProgressIndicator()));
          }
        });
  }
}
