import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_management/decider_screen.dart';

class EmailConfirmationController extends GetxController {
  final email = ''.obs;
  final isSending = false.obs;
  final isVerified = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    final user = _auth.currentUser;
    if (user != null) {
      email.value = user.email ?? '';
      if (!user.emailVerified) {
        sendVerificationEmail();
      } else {
        isVerified.value = true;
      }
    }
    super.onInit();
  }

  Future<void> sendVerificationEmail() async {
    try {
      isSending.value = true;
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Get.snackbar('Email Sent', 'Verification email sent to ${user.email}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to send email: $e');
    } finally {
      isSending.value = false;
    }
  }

  Future<void> checkEmailVerified() async {
    await _auth.currentUser?.reload();
    final user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      isVerified.value = true;
      Get.snackbar('Verified', 'Email is verified!');
      // Navigate to next screen if you want:
      Get.offAll(() => DeciderScreen());
    } else {
      isVerified.value = false;
      Get.snackbar('Not Verified', 'Please verify your email first.');
    }
  }
  // Future<void> checkWardenEmailVerified() async {
  //   await _auth.currentUser?.reload();
  //   final user = _auth.currentUser;
  //
  //   if (user != null && user.emailVerified) {
  //     isVerified.value = true;
  //     Get.snackbar('Verified', 'Email is verified!');
  //     // Navigate to next screen if you want:
  //     Get.offAll(() => DeciderScreen());
  //   } else {
  //     isVerified.value = false;
  //     Get.snackbar('Not Verified', 'Please verify your email first.');
  //   }
  // }
}
