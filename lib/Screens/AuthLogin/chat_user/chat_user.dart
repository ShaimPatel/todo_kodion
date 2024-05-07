class ClientData {
  late String image;
  late String lastActive;
  late String name;
  late String id;
  late String message;
  late bool isActive;
  late String email;
  late String pushToken;

  ClientData({
    required this.image,
    required this.lastActive,
    required this.name,
    required this.id,
    required this.message,
    required this.isActive,
    required this.email,
    required this.pushToken,
  });

  ClientData.fromJson(Map<String, dynamic> json) {
    image = json["image"] ?? "";
    lastActive = json["lastActive"] ?? "";
    name = json["name"] ?? "";
    id = json["id"] ?? "";
    message = json["message"] ?? "";
    isActive = json["isActive"] ?? "";
    email = json["email"] ?? "";
    pushToken = json["push_token"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["image"] = image;
    data["lastActive"] = lastActive;
    data["name"] = name;
    data["id"] = id;
    data["message"] = message;
    data["isActive"] = isActive;
    data["email"] = email;
    data["push_token"] = pushToken;
    return data;
  }
}
