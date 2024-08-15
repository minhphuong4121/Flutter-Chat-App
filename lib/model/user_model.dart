class UserModel {
  String? id;
  String? name;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? about;
  String? cratedAt;
  String? lastOnlineStatus;
  String? status;
  String? role;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.profileImage,
      this.phoneNumber,
      this.about,
      this.cratedAt,
      this.lastOnlineStatus,
      this.status,
      this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    profileImage = json["profileImage"];
    phoneNumber = json["phoneNumber"];
    about = json["About"];
    cratedAt = json["CratedAt"];
    lastOnlineStatus = json["LastOnlineStatus"];
    status = json["Status"];
    role = json["role"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["profileImage"] = profileImage;
    _data["phoneNumber"] = phoneNumber;
    _data["About"] = about;
    _data["CratedAt"] = cratedAt;
    _data["LastOnlineStatus"] = lastOnlineStatus;
    _data["Status"] = status;
    _data["role"] = role;
    return _data;
  }
}
