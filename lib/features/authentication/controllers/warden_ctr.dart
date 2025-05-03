// controllers/student_controller.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hostel_management/features/authentication/controllers/warden_signup_ctr.dart';
import 'package:hostel_management/features/authentication/model/warden.dart';

import '../model/student.dart';

class WardenCtr extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _dbRef = FirebaseDatabase.instanceFor(  app: Firebase.app(),
    databaseURL: 'https://hostel-management-9b5cc-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref();
  var student = Rxn<WardenModel>();
  var isLoading = true.obs;
  var isChecked = true.obs;
void isToggle(){
  isChecked.value = !isChecked.value;
}

  @override
  void onInit() {
    fetchWardenData();
    super.onInit();
  }

  void fetchWardenData() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        isLoading.value = false;
        return;
      }

      final snapshot = await _dbRef.child(FirebaseStrings.wardens).child(uid).once();

      if (snapshot.snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.snapshot.value as Map);
        student.value = WardenModel.fromJson(data);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateWarden(WardenModel updateWarden) async {
    try {
      await _dbRef
          .child(FirebaseStrings.wardens)
          .child(updateWarden.userUid)
          .update(updateWarden.toJson());

      student.value = updateWarden;

      Get.snackbar("Success", "Student info updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update: $e");
    }
  }
}
