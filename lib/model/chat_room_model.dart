import 'package:flutter_my_chat_app/model/chat_model.dart';
import 'package:flutter_my_chat_app/model/user_model.dart';

class ChatRoomModel {
  String? id;
  UserModel? sender;
  UserModel? receiver;
  List<ChatModel>? messages;
  int? unReadMessNo;
  String? lastMessage;
  String? lastMessageTimestamp;
  String? timestamp;

  ChatRoomModel(
      {this.id,
      this.sender,
      this.receiver,
      this.messages,
      this.unReadMessNo,
      this.lastMessage,
      this.lastMessageTimestamp,
      this.timestamp});

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    sender = json["sender"] == null ? null : UserModel.fromJson(json["sender"]);
    receiver =
        json["receiver"] == null ? null : UserModel.fromJson(json["receiver"]);
    messages = json["messages"] ?? [];
    unReadMessNo = json["unReadMessNo"];
    lastMessage = json["lastMessage"];
    lastMessageTimestamp = json["lastMessageTimestamp"];
    timestamp = json["timestamp"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    if (sender != null) {
      _data["sender"] = sender?.toJson();
    }
    if (receiver != null) {
      _data["receiver"] = receiver?.toJson();
    }
    if (messages != null) {
      _data["messages"] = messages;
    }
    _data["unReadMessNo"] = unReadMessNo;
    _data["lastMessage"] = lastMessage;
    _data["lastMessageTimestamp"] = lastMessageTimestamp;
    _data["timestamp"] = timestamp;
    return _data;
  }
}

// class Receiver {
//   Receiver();

//   Receiver.fromJson(Map<String, dynamic> json) {

//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};

//     return _data;
//   }
// }

// class Sender {
//   Sender();

//   Sender.fromJson(Map<String, dynamic> json) {

//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};

//     return _data;
//   }
// }