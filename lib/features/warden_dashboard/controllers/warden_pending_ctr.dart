import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hostel_management/features/authentication/controllers/warden_signup_ctr.dart';

class PendingRequest {
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

  PendingRequest({
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
  factory PendingRequest.fromMap(Map<dynamic, dynamic> data) {
    return PendingRequest(
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
  factory PendingRequest.fromJson(Map<String, dynamic> json) {
    return PendingRequest.fromMap(json);
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() => toMap();

  /// Copy the object with optional updated fields
  PendingRequest copyWith({
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
    return PendingRequest(
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

    return other is PendingRequest &&
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

class WardenPendingRequestController extends GetxController {
  final database = FirebaseDatabase.instance.ref();
  final RxList<PendingRequest> pendingRequests = <PendingRequest>[].obs;
  final RxBool isLoading = true.obs;
  final RxString userUid = FirebaseAuth.instance.currentUser!.uid.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPendingRequests();
  }

  Future<void> fetchPendingRequests() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final uid = currentUser.uid;

    try {
      isLoading.value = true;
      final snapshot = await database
          .child(FirebaseStrings.pendingRequests)
          .child(uid)
          .get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;

        pendingRequests.value = data.entries.map((entry) {
          final request = entry.value as Map<dynamic, dynamic>;
          return PendingRequest.fromMap(request);
        }).toList();
      } else {
        pendingRequests.clear();
      }
    } catch (e) {
      print("Error fetching pending requests: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> approveRequest({
    required String hostelUid,
    required String requestKey,
    required Map<String, dynamic> requestData,
  }) async {
    try {
      // Add to approvedRequests
      await database.child(FirebaseStrings.approvedRequests).child(hostelUid).child(requestKey).set({
        ...requestData,
        'approvedStatus': true,
      });

      // Remove from pending
      await database.child(FirebaseStrings.pendingRequests).child(hostelUid).child(requestKey).remove();

      // Remove from UI list
      pendingRequests.removeWhere((req) => req.userUid == requestKey);
    } catch (e) {
      print("Error approving request: $e");
    }
  }

  Future<void> rejectRequest({
    required String hostelUid,
    required String requestKey,
  }) async {
    try {
      // Just remove from pending
      await database.child(FirebaseStrings.pendingRequests).child(hostelUid).child(requestKey).remove();

      // Remove from UI list
      pendingRequests.removeWhere((req) => req.userUid == requestKey);
    } catch (e) {
      print("Error rejecting request: $e");
    }
  }
}
