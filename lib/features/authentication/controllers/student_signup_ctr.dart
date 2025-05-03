import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hostel_management/decider_screen.dart';
import 'package:hostel_management/features/authentication/controllers/warden_signup_ctr.dart';
import 'package:hostel_management/features/authentication/screens/login/email_conformation.dart';
import 'package:hostel_management/features/authentication/screens/onboarding/onboarding.dart';
import 'package:hostel_management/navigation_menu.dart';

import '../model/student.dart';

const String databaseUrl = 'https://hostel-management-9b5cc-default-rtdb.asia-southeast1.firebasedatabase.app';
class RegisterStudentController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
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

  void registerStudent() async {
    isLoading.value = true;

    try {
      // Step 1: Create user with email and password
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
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
        password: passwordController.text.trim(), // not recommended to store plain passwords
      );

      // Step 3: Save student data to Realtime Database
try{
  await _database.ref().child(FirebaseStrings.students).child(uid).set(student.toJson());
  print(student.toJson());
  print(">>>>>>>>>>>>>>>>>Everything is fine<<<<<<<<<<<<<<<");


}catch(e){
  print(student.toJson());
  print(e);
}
      Get.snackbar('Success', 'Verification Email Send Successfully');
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
