import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_chat_app/model/audio_call_model.dart';
import 'package:flutter_my_chat_app/model/user_model.dart';
import 'package:flutter_my_chat_app/pages/call/audio_call_page.dart';
import 'package:flutter_my_chat_app/pages/call/video_call_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CallController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = Uuid().v4();

  @override
  void onInit() {
    super.onInit();
    getCallNotification().listen((List<CallModel> callList) {
      if (callList.isNotEmpty) {
        var callData = callList[0];
        if (callData.type == "audio") {
          audioCallNotification(callData);
        } else if (callData.type == "video") {
          videoCallNotification(callData);
        }
      }
    });
  }

  Future<void> audioCallNotification(CallModel callData) async {
    Get.snackbar(
      duration: const Duration(
        days: 1,
      ),
      backgroundColor: Colors.grey,
      barBlur: 0,
      isDismissible: false,
      icon: const Icon(Icons.call),
      onTap: (snack) {
        Get.back();
        Get.to(
          AudioCallPage(
            target: UserModel(
              id: callData.callerUid,
              name: callData.callerName,
              email: callData.callerEmail,
              profileImage: callData.callerPic,
            ),
          ),
        );
      },
      callData.callerName!,
      "Incoming Audio call",
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: const Text("End Call"),
      ),
    );
  }

  void videoCallNotification(CallModel callData) {
    Get.snackbar(
      duration: const Duration(
        days: 1,
      ),
      backgroundColor: Colors.grey,
      barBlur: 0,
      isDismissible: false,
      icon: const Icon(Icons.video_call),
      onTap: (snack) {
        Get.back();
        Get.to(
          VideoCallPage(
            target: UserModel(
              id: callData.callerUid,
              name: callData.callerName,
              email: callData.callerEmail,
              profileImage: callData.callerPic,
            ),
          ),
        );
      },
      callData.callerName!,
      "Incoming Video call",
      mainButton: TextButton(
        onPressed: () {
          endCall(callData);
          Get.back();
        },
        child: const Text("End Call"),
      ),
    );
  }

  Future<void> callAction(
      UserModel receiver, UserModel caller, String type) async {
    String id = uuid;
    DateTime timeStamp = DateTime.now();
    String formattedTime = DateFormat("hh:mm a").format(timeStamp);
    var newCall = CallModel(
      id: id,
      callerName: caller.name,
      callerPic: caller.profileImage,
      callerUid: caller.id,
      callerEmail: caller.email,
      receiverName: receiver.name,
      receiverPic: receiver.profileImage,
      receiverUid: receiver.id,
      receiverEmail: receiver.email,
      status: "calling",
      type: type,
      time: formattedTime,
      timestamp: DateTime.now().toString(),
    );
    try {
      await db
          .collection("notification")
          .doc(receiver.id)
          .collection("call")
          .doc(id)
          .set(newCall.toJson());

      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());

      await db
          .collection("users")
          .doc(receiver.id)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());

      Future.delayed(Duration(seconds: 20), () {
        endCall(newCall);
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<List<CallModel>> getCallNotification() {
    return FirebaseFirestore.instance
        .collection("notification")
        .doc(auth.currentUser!.uid)
        .collection("call")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CallModel.fromJson(doc.data()))
            .toList());
  }

  Future<void> endCall(CallModel call) async {
    try {
      await db
          .collection("notification")
          .doc(call.receiverUid)
          .collection("call")
          .doc(call.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
