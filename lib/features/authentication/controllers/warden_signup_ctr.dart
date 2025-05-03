import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hostel_management/decider_screen.dart';
import 'package:hostel_management/features/authentication/controllers/student_signup_ctr.dart';
import 'package:hostel_management/features/authentication/model/warden.dart';
import 'package:hostel_management/features/authentication/screens/login/email_conformation.dart';
import 'package:hostel_management/features/authentication/screens/onboarding/onboarding.dart';
import 'package:hostel_management/features/warden_dashboard/home/warden_nav_menu.dart';
import 'package:hostel_management/navigation_menu.dart';

import '../model/student.dart';
class FirebaseStrings {
  FirebaseStrings._();
  static String students = "Students";
  static String hostels = "HostelsList";
  static String wardens = "Wardens";
  static String pendingRequests = "PendingRequests";
  static String approvedRequests = "ApprovedRequests";
  static String foodComplains = "FoodComplains";
  static String helpCenter = "HelpCenter";
  static String outingLeave = "OutingLeave";
}
class RegisterWardenController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final hostelName = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isChecked = true.obs;

  void isToggle(){
    isChecked.value = !isChecked.value;
  }

  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instanceFor(  app: Firebase.app(),
    databaseURL: databaseUrl,
  );

  void registerWarden() async {
    isLoading.value = true;

    try {
      // Step 1: Create user with email and password
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final String uid = userCredential.user!.uid;

      // Step 2: Prepare student data
      final warden = WardenModel(
        userUid: _auth.currentUser!.uid,
        firstName: firstNameController.text.trim(),
        hostelName: hostelName.text.trim(),
        lastName: lastNameController.text.trim(),
        address: addressController.text.trim(),
        phone: phoneController.text.trim(),
        date: dateController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(), // not recommended to store plain passwords
      );

      // Step 3: Save student data to Realtime Database
      try{
        await _database.ref().child(FirebaseStrings.wardens).child(uid).set(warden.toJson());
        final hostelListRef = _database.ref(FirebaseStrings.hostels);
        final newHostelName = hostelName.text.trim();

        final existingSnapshot = await hostelListRef.get();

        List<dynamic> updatedList = [];

        if (existingSnapshot.exists) {
          final data = existingSnapshot.value;

          // If it's a List already
          if (data is List) {
            updatedList = List<String>.from(data);
          }

          // If it's a Map like {0: ..., 1: ...}
          else if (data is Map) {
            updatedList = data.values.map((e) => e.toString()).toList();
          }
        }

// Add the new hostel name if it's not already there
        if (!updatedList.contains(newHostelName)) {
          updatedList.add(newHostelName);
          await hostelListRef.set(updatedList);
        }

        print(warden.toJson());
        print(">>>>>>>>>>>>>>>>>Everything is fine<<<<<<<<<<<<<<<");


      }catch(e){
        print(warden.toJson());
        print(e);
      }
      Get.snackbar('Success', 'Student Registered Successfully');
      clearFields();
      Get.to(()=> EmailConfirmationScreen());

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
