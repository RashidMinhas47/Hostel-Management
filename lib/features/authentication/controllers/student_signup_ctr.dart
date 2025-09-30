import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hostel_management/decider_screen.dart';
import 'package:hostel_management/features/authentication/controllers/warden_signup_ctr.dart';
import 'package:hostel_management/features/authentication/screens/login/email_conformation.dart';

import '../model/student.dart';

const String databaseUrl =
    'https://hostel-management-9b5cc-default-rtdb.asia-southeast1.firebasedatabase.app';

class RegisterStudentController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final educationController = TextEditingController();

  // Hostel related fields
  RxString selectedHostel = ''.obs;
  RxString selectedUid = ''.obs;
  RxList<Map<String, String>> hostelInfoList = <Map<String, String>>[].obs;
  RxInt selectedStudentCount = 1.obs;
  final List<int> studentCountOptions = [1, 2, 3, 4, 5];

  final isLoading = false.obs;
  final isChecked = true.obs;
  void isToggle() {
    isChecked.value = !isChecked.value;
  }

  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: databaseUrl,
  );

  @override
  void onInit() {
    super.onInit();
    fetchHostelList();
  }

  Future<void> fetchHostelList() async {
    final ref = _database.ref();
    final snapshot = await ref.child(FirebaseStrings.wardens).get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      hostelInfoList.clear();
      data.forEach((wardenUid, value) {
        final wardenData = value as Map<dynamic, dynamic>;
        if (wardenData['hostelName'] != null) {
          hostelInfoList.add({
            'hostelName': wardenData['hostelName'].toString(),
            'userUid': wardenData['userUid'].toString(),
          });
        }
      });
    }
  }

  void registerStudent() async {
    isLoading.value = true;

    try {
      // Step 1: Create user with email and password
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final String uid = userCredential.user!.uid;

      // Step 2: Prepare student data
      final student = StudentModel(
        userUid: _auth.currentUser!.uid,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        address: addressController.text.trim(),
        phone: phoneController.text.trim(),
        date: dateController.text.trim(),
        email: emailController.text.trim(),
        password:
            passwordController.text
                .trim(), // not recommended to store plain passwords
        education: educationController.text.trim(),
        studentCount: selectedStudentCount.value,
        hostelName: selectedHostel.value,
      );

      // Step 3: Save student data to Realtime Database
      try {
        await _database
            .ref()
            .child(FirebaseStrings.students)
            .child(uid)
            .set(student.toJson());
        print(student.toJson());
        print(">>>>>>>>>>>>>>>>>Everything is fine<<<<<<<<<<<<<<<");
      } catch (e) {
        print(student.toJson());
        print(e);
      }
      // Step 4: Create PendingRequest for the selected hostel (if provided)
      try {
        if (selectedUid.value.isNotEmpty) {
          final requestData = {
            'firstName': student.firstName,
            'lastName': student.lastName,
            'address': student.address,
            'phone': student.phone,
            'email': student.email,
            'education': student.education,
            'studentCount': student.studentCount,
            'hostelName': student.hostelName,
            'requestUid': uid,
            'userUid': uid,
            'timestamp': DateTime.now().toIso8601String(),
            'approvedStatus': false,
          };

          await _database
              .ref()
              .child(FirebaseStrings.pendingRequests)
              .child(selectedUid.value)
              .child(uid)
              .set(requestData);
        }
      } catch (e) {
        print('Error creating pending request: $e');
      }
      Get.snackbar('Success', 'Verification Email Send Successfully');
      clearFields();
      Get.to(() => EmailConfirmationScreen());
    } on FirebaseAuthException catch (e) {
      print(">>>>>>>>>>>>>>>>>$e<<<<<<<<<<<<<<<");

      Get.snackbar('Auth Error', e.message ?? 'Authentication Failed');
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>$e<<<<<<<<<<<<<<<");
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    firstNameController.clear();
    lastNameController.clear();
    addressController.clear();
    phoneController.clear();
    dateController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    dateController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// 🔓 Logout function
  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.snackbar('Logged Out', 'You have been successfully logged out');
      // Optional: Navigate to login or onboarding screen
      Get.offAll(() => DeciderScreen()); // uncomment if needed
    } catch (e) {
      Get.snackbar('Logout Error', 'Failed to logout: $e');
    }
  }
}
