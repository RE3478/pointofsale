class UserProfile {
  final String personalName;
  final String phoneNo;
  final String address;
  final String image;

  UserProfile({
    required this.personalName,
    required this.phoneNo,
    required this.address,
    required this.image,
  });

  factory UserProfile.fromMap(map) => UserProfile(
        personalName: map['personalName'],
        phoneNo: map['phoneNo'],
        address: map['address'],
        image: map['image'],
      );

  Map<String, dynamic> toMap() {
    return {
      "personalName": personalName,
      "phoneNo": phoneNo,
      "address": address,
      "image": image,
    };
  }
}
