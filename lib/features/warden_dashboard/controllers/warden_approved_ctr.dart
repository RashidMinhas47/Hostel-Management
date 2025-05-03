import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_management/features/authentication/controllers/warden_signup_ctr.dart';
class RequestModel {
  final String firstName;
  final String lastName;
  final String address;
  final String role;
  final String phone;
  final String email;
  final String education;
  final String studentCount;
  final String hostelName;
  final String userUid;

  RequestModel({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.role,
    required this.phone,
    required this.email,
    required this.education,
    required this.studentCount,
    required this.hostelName,
    required this.userUid,
  });

  /// Factory constructor from Firebase Realtime Database map
  factory RequestModel.fromMap(Map<dynamic, dynamic> data) {
    return RequestModel(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      role: data['role'] ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      education: data['education'] ?? '',
      studentCount: data['studentCount']?.toString() ?? '',
      hostelName: data['hostelName'] ?? '',
      userUid: data['userUid'] ?? '',
    );
  }

  /// Convert model to Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'address': address,
      'phone': phone,
      'email': email,
      'education': education,
      'studentCount': studentCount,
      'hostelName': hostelName,
      'userUid': userUid,
    };
  }

  /// Factory constructor from JSON
  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel.fromMap(json);
  }

  factory RequestModel.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map<dynamic, dynamic>;
    return RequestModel.fromMap(data);
  }
  /// Convert model to JSON
  Map<String, dynamic> toJson() => toMap();

  /// Copy the object with optional updated fields
  RequestModel copyWith({
    String? firstName,
    String? lastName,
    String? address,
    String? role,
    String? phone,
    String? email,
    String? education,
    String? studentCount,
    String? hostelName,
    String? userUid,
  }) {
    return RequestModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      education: education ?? this.education,
      studentCount: studentCount ?? this.studentCount,
      hostelName: hostelName ?? this.hostelName,
      userUid: userUid ?? this.userUid,
    );
  }

  /// Full name getter
  String get fullName => '$firstName $lastName';

  @override
  String toString() {
    return 'PendingRequest(firstName: $firstName, lastName: $lastName, role: $role, address: $address, phone: $phone, email: $email, education: $education, studentCount: $studentCount, hostelName: $hostelName, userUid: $userUid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestModel &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.address == address &&
        other.role == role &&
        other.phone == phone &&
        other.email == email &&
        other.education == education &&
        other.studentCount == studentCount &&
        other.hostelName == hostelName &&
        other.userUid == userUid;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
    lastName.hashCode ^
    address.hashCode ^
    role.hashCode ^
    phone.hashCode ^
    email.hashCode ^
    education.hashCode ^
    studentCount.hashCode ^
    hostelName.hashCode ^
    userUid.hashCode;
  }
}




class WardenApprovedRequestController extends GetxController {
  final approvedRequests = <RequestModel>[].obs;
  final isLoading = true.obs;

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    listenToApprovedRequests();
  }

  void listenToApprovedRequests() {
    isLoading.value = true;

    _dbRef.child(FirebaseStrings.approvedRequests).child(userUid).onValue.listen((event) {
      final List<RequestModel> updatedList = [];

      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          if (value['approvedStatus'] == true) {
            final request = RequestModel.fromMap(value);
            updatedList.add(request);
          }
        });
      }

      approvedRequests.value = updatedList;
      isLoading.value = false;
    });
  }
}