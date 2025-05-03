import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hostel_management/decider_screen.dart';
import 'package:hostel_management/features/authentication/controllers/warden_signup_ctr.dart';

import '../../../../authentication/controllers/student_signup_ctr.dart';

class HelpCenterController extends GetxController {
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final isLoading = false.obs;

  final database = FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: databaseUrl).ref();
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final email = FirebaseAuth.instance.currentUser?.email;

  @override
  void onInit() {
    super.onInit();
    emailController.text = email ?? '';
  }

  void sendHelpMessage() async {
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
      final helpRef = database.child(FirebaseStrings.helpCenter).child(uid!).push();

      await helpRef.set({
        "email": email,
        "message": message,
        "timestamp": DateTime.now().toIso8601String(),
      });

      Get.snackbar("Success", "Your message was sent to Help Center.");
      emailController.clear();
      messageController.clear();
      Get.offAll(() => DeciderScreen());
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again.");
      debugPrint("HelpCenter Error: $e");
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
