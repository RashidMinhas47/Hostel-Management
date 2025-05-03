import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hostel_management/decider_screen.dart';
import 'package:hostel_management/features/authentication/controllers/student_signup_ctr.dart';
import 'package:hostel_management/features/authentication/controllers/warden_signup_ctr.dart';

class FoodFormController extends GetxController {
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final isLoading = false.obs;

  final database = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: databaseUrl).ref();
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final email = FirebaseAuth.instance.currentUser?.email;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController.text = email ?? "";
  }

  void sendComplaint() async {
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    if (email.isEmpty || message.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields.");
      return;
    }

    if (uid == null) {
      Get.snackbar("Error", "User not logged in.");
      return;
    }

    isLoading.value = true;

    try {
      final complaintRef = database.child(FirebaseStrings.foodComplains).child(uid!).push();

      await complaintRef.set({
        "email": email,
        "message": message,
        "timestamp": DateTime.now().toIso8601String(),
      });

      Get.snackbar("Success", "Complaint submitted successfully.");
      emailController.clear();
      messageController.clear();
      Get.offAll(()=>DeciderScreen());
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again.");
      debugPrint("Complaint Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
