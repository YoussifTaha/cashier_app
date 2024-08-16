
class LoginModel {
  late String email;
  // late String password;
  late String phone;
  late String userName;
  late String uId;
  late bool? isEmailVerified;

  LoginModel({
    required this.email,
    // required this.password,
    required this.phone,
    required this.userName,
    required this.uId,
    required this.isEmailVerified,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    // password = json['password'];
    phone = json['phone'];
    userName = json['userName'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap()
  {
    return
      {
        'email' : email,
        'phone' : phone,
        'userName' : userName,
        'uId' : uId,
        'isEmailVerified' : isEmailVerified,
      };
  }
}
