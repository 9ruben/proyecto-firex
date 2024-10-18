class UserModel {
  String? id;
  String fullName;
  String email;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
  });

  // Convert an instance to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
      };

  // Factory constructor to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'], // id puede ser null
        fullName: json["fullName"],
        email: json["email"],
      );
}