class AppUser {
  final String userId;
  final String? userMail;

  AppUser(this.userId, this.userMail);
}

class UserModel {
  String? name;
  String? height;
  String? weight;
  String? age;
  String? gender;
  String? email;
  String? uid;

  UserModel({
    this.name,
    this.height,
    this.weight,
    this.age,
    this.gender,
    this.email,
    this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['fullName'] as String?,
      height: json['height'].toString(),
      weight: json['weight'].toString(),
      age: json['age'].toString(),
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      uid: json['uid'] as String?,
    );
  }
}
