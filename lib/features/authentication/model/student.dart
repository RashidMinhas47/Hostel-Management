// models/student_model.dart
class StudentModel {
  final String firstName;
  final String lastName;
  final String address;
  final String phone;
  final String date;
  final String email;
  final String password;
  final String userUid;

  StudentModel({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phone,
    required this.date,
    required this.email,
    required this.password,
    required this.userUid
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'address': address,
    'phone': phone,
    'date': date,
    'email': email,
    'password': password,
    'userUid' : userUid,
  };

  factory StudentModel.fromJson(Map<dynamic, dynamic> json) {
    return StudentModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      date: json['date'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      userUid: json['userUid'] ?? '',
    );
  }
  StudentModel copyWith({
    String? firstName,
    String? lastName,
    String? address,
    String? phone,
    String? date,
    String? email,
    String? password,
    String? userUid,
  }) {
    return StudentModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      date: date ?? this.date,
      email: email ?? this.email,
      password: password ?? this.password,
      userUid: userUid ?? this.userUid,
    );
  }
}
