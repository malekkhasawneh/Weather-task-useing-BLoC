class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? userImageUrl;

  UserModel(
      {this.uid,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.userImageUrl});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
      email: map['email'],
      userImageUrl: map['userImageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'userImageUrl': userImageUrl,
    };
  }
}
