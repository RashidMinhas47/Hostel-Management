class WardenModel {
  final String firstName;
  final String lastName;
  final String address;
  final String phone;
  final String date;
  final String email;
  final String password;
  final String userUid;
  final String hostelName;
  final double? latitude;
  final double? longitude;

  WardenModel({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phone,
    required this.date,
    required this.email,
    required this.password,
    required this.userUid,
    required this.hostelName,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'address': address,
    'phone': phone,
    'date': date,
    'email': email,
    'password': password,
    'userUid': userUid,
    'hostelName': hostelName,
    'latitude': latitude,
    'longitude': longitude,
  };

  factory WardenModel.fromJson(Map<dynamic, dynamic> json) {
    return WardenModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      date: json['date'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      userUid: json['userUid'] ?? '',
      hostelName: json['hostelName'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  WardenModel copyWith({
    String? firstName,
    String? lastName,
    String? address,
    String? phone,
    String? date,
    String? email,
    String? password,
    String? userUid,
    String? hostelName,
    double? latitude,
    double? longitude,
  }) {
    return WardenModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      date: date ?? this.date,
      email: email ?? this.email,
      password: password ?? this.password,
      userUid: userUid ?? this.userUid,
      hostelName: hostelName ?? this.hostelName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
