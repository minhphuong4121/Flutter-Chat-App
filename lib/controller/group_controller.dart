import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_my_chat_app/config/custom_message.dart';
import 'package:flutter_my_chat_app/controller/profile_controller.dart';
import 'package:flutter_my_chat_app/model/chat_model.dart';
import 'package:flutter_my_chat_app/model/group_model.dart';
import 'package:flutter_my_chat_app/model/user_model.dart';
import 'package:flutter_my_chat_app/pages/home/home_page.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class GroupController extends GetxController {
  final auth = FirebaseAuth.instance;
  RxList<UserModel> groupMembers = <UserModel>[].obs;
  final db = FirebaseFirestore.instance;
  var uuid = Uuid();
  ProfileController profileController = Get.put(ProfileController());
  RxBool isLoading = false.obs;
  RxList<GroupModel> groupList = <GroupModel>[].obs;
  RxString selectedImagePath = "".obs;

  @override
  void onInit() {
    super.onInit();
    getGroups();
  }

  void selectMember(UserModel user) {
    if (groupMembers.contains(user)) {
    } else {
      groupMembers.add(user);
    }
  }

  Future<void> createGroup(String groupName, String imagePath) async {
    isLoading.value = true;
    String groupId = uuid.v6();
    groupMembers.add((UserModel(
      id: auth.currentUser!.uid,
      name: profileController.currentUser.value.name,
      profileImage: profileController.currentUser.value.profileImage,
      email: profileController.currentUser.value.email,
      role: "admin",
    )));
    try {
      String imageUrl = await profileController.uploadFileToFirebase(imagePath);
      await db.collection("groups").doc(groupId).set({
        "id": groupId,
        "name": groupName,
        "profileUrl": imageUrl,
        "members": groupMembers.map((e) => e.toJson()).toList(),
        "createdAt": DateTime.now().toString(),
        "createdBy": auth.currentUser!.uid,
        "timestamp": DateTime.now().toString(),
      });
      getGroups();
      // Group created notifications
      successMessage("Group created successfully");
      Get.offAll(const HomePage());
      isLoading.value = false;
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  Future<void> getGroups() async {
    isLoading.value = true;
    List<GroupModel> tempGroup = [];

    await db.collection("groups").get().then(
      (value) {
        tempGroup =
            value.docs.map((e) => GroupModel.fromJson(e.data())).toList();
      },
    );
    groupList.clear();
    groupList.value = tempGroup
        .where(
          (e) =>
              e.members!.any((element) => element.id == auth.currentUser!.uid),
        )
        .toList();

    isLoading.value = false;
  }

  Future<void> sendGrouPMessage(
      String message, String groupId, String imagePath) async {
    isLoading.value = true;
    String imageUrl =
        await profileController.uploadFileToFirebase(selectedImagePath.value);
    var chatId = uuid.v6();
    var newChat = ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl,
      senderId: auth.currentUser!.uid,
      senderName: profileController.currentUser.value.name,
      timestamp: DateTime.now().toString(),
    );

    await db
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .doc(chatId)
        .set(newChat.toJson());

    selectedImagePath.value = "";
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getGroupMessages(String groupId) {
    return db
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => ChatModel.fromJson(doc.data()),
            )
            .toList());
  }

  Future<void> addMemberToGroup(String groupId, UserModel user) async {
    isLoading.value = true;

    await db.collection("groups").doc(groupId).update(
      {
        "members": FieldValue.arrayUnion([user.toJson()]),
      },
    );
    getGroups();
    isLoading.value = false;
  }
}
