import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_management/features/authentication/screens/password_configuration/reset_password.dart';

class ForgetPasswordController extends GetxController {
  // Email controller
  final emailController = TextEditingController();

  // Loading state
  final isLoading = false.obs;

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to send reset email
  Future<void> sendPasswordResetEmail() async {
    FirebaseAuth.instance.setLanguageCode("en"); // or "es", "fr", etc.

    final email = emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar('Invalid Email', 'Please enter a valid email address');
      return;
    }

    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email);

      Get.snackbar('Success', 'Password reset link sent to $email');

      // Get.off(() => const ResetPassword());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Failed to send reset email');
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
      print('Password Reset Error: $e');
    } finally {
      isLoading.value = false;
      Get.to(()=>ResetPassword());
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
