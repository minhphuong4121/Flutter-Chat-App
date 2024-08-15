
import 'package:flutter_my_chat_app/model/user_model.dart';

class GroupModel {
  String? id;
  String? name;
  String? description;
  String? profileUrl;
  List<UserModel>? members;
  String? createdAt;
  String? createdBy;
  String? status;
  String? lastMessage;
  String? lastMessageTime;
  String? lastMessageBy;
  int? unReadCount;
  String? timestamp;

  GroupModel(
      {this.id,
      this.name,
      this.description,
      this.profileUrl,
      this.members,
      this.createdAt,
      this.createdBy,
      this.status,
      this.lastMessage,
      this.lastMessageTime,
      this.lastMessageBy,
      this.unReadCount,
      this.timestamp});

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    profileUrl = json["profileUrl"];
    // members = json["members"] ?? [];

    // if (json["members"] != null) {
    //   json["members"] == null ? null : UserModel.fromJson(json["members"]);
    // }

    if (json["members"] != null) {
      members = List<UserModel>.from(
          json["members"].map((memberJson) => UserModel.fromJson(memberJson)));
    } else {
      members = [];
    }

    createdAt = json["createdAt"];
    createdBy = json["createdBy"];
    status = json["status"];
    lastMessage = json["lastMessage"];
    lastMessageTime = json["lastMessageTime"];
    lastMessageBy = json["lastMessageBy"];
    unReadCount = json["unReadCount"];
    timestamp = json["timestamp"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["profileUrl"] = profileUrl;
    if (members != null) {
      _data["members"] = members;
    }
    _data["createdAt"] = createdAt;
    _data["createdBy"] = createdBy;
    _data["status"] = status;
    _data["lastMessage"] = lastMessage;
    _data["lastMessageTime"] = lastMessageTime;
    _data["lastMessageBy"] = lastMessageBy;
    _data["unReadCount"] = unReadCount;
    _data["timestamp"] = timestamp;
    return _data;
  }
}
