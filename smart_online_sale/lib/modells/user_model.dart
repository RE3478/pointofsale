class UserModel {
  final String uid;
  final String name;
  final String userType;
  final String email;
  final String password;

  UserModel({
    required this.uid,
    required this.name,
    required this.userType,
    required this.email,
    required this.password,
  });
  factory UserModel.fromMap(map) => UserModel(
      uid: map['uid'],
      name: map['name'],
      userType: map['userType'],
      email: map['email'],
      password: map['password']);
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "userType": userType,
      "email": email,
      "password": password
    };
  }
}
