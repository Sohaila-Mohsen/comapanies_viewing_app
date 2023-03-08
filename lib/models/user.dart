class UserResponse {
  bool? status;
  String? message;
  User? user;

  UserResponse({this.status, this.message, this.user});

  UserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['data'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? email;
  String? name;
  String? phone;
  String? password;
  int? id;
  String? image;
  String? token;

  User(
      {this.email,
      this.name,
      this.phone,
      this.id,
      this.image,
      this.token,
      this.password});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (email != null && email!.isNotEmpty) data['email'] = email;
    if (name != null && name!.isNotEmpty) data['name'] = name;
    if (phone != null && phone!.isNotEmpty) data['phone'] = phone;
    if (id != null) data['id'] = id;
    if (image != null && image!.isNotEmpty) data['image'] = image;
    if (token != null && token!.isNotEmpty) data['token'] = token;
    if (password != null && password!.isNotEmpty) data['password'] = password;
    return data;
  }
}
