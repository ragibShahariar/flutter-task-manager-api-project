class UserModel {
  late final String id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String mobile;
  late final String createdDate;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.createdDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['id'] ?? '',
      email: jsonData['email'] ?? '',
      firstName: jsonData['firstName'] ?? '',
      lastName: jsonData['lastName'] ?? '',
      mobile: jsonData['mobile'] ?? '',
      createdDate: jsonData['createdDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'createdDate': createdDate,
    };
  }

  String get fullName{
    return '$firstName $lastName';
  }
}
