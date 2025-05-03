import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_management/decider_screen.dart';

class LoginController extends GetxController {
  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Loading state
  final isLoading = false.obs;
  final isChecked = true.obs;
void isToggle(){
  isChecked.value = !isChecked.value;
}
  // Firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login method
  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter both email and password');
      return;
    }

    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Get.snackbar('Success', 'Login successful');
      Get.offAllNamed('/home'); // Navigate to Home screen (change route as needed)

    } on FirebaseAuthException catch (e) {
      String message = 'Login failed';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      }
      Get.snackbar('Error', message);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
      print("Login Error: $e");
    } finally {
      isLoading.value = false;
      Get.offAll(()=>DeciderScreen());
    }
  }

  // Dispose controllers
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
