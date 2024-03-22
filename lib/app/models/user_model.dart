class UserModel {
  String email;
  String id;
  String userName;

  UserModel({required this.email, required this.id, required this.userName});

  factory UserModel.formMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      id: map['id'],
      userName: map['userName'],
    );
  }
}
