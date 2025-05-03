import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hostel_management/features/authentication/controllers/student_signup_ctr.dart';
import 'package:hostel_management/features/authentication/controllers/warden_signup_ctr.dart';
import '../../../../authentication/model/student.dart';
import '../views/hostel_booking.dart';
import '../views/registration_popup.dart';

class HostelBookingController extends GetxController {
  // Text Fields
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final mobileNumber = TextEditingController();
  final email = TextEditingController();
  final education = TextEditingController();

  // Dropdowns
  RxString selectedHostel = ''.obs;
  RxString selectedUid = ''.obs;
  RxList<Map<String, String>> hostelInfoList = <Map<String, String>>[].obs;

  RxInt selectedStudentCount = 1.obs;
  final studentCountOptions = [1, 2, 3, 4, 5];

  // Firebase Realtime DB ref
  final db = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: databaseUrl).ref();

  @override
  void onInit() {
    super.onInit();
    loadInitialUserData();
    fetchHostelList();
  }

  Future<void> loadInitialUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await db.child('${FirebaseStrings.students}/${user.uid}').get();

    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      firstName.text = data['firstName'] ?? '';
      lastName.text = data['lastName'] ?? '';
      address.text = data['address'] ?? '';
      mobileNumber.text = data['phone'] ?? '';
      email.text = data['email'] ?? '';
      education.text = data['education'] ?? '';
    }
  }


  // Fetch function
  Future<void> fetchHostelList() async {
    final snapshot = await db.child(FirebaseStrings.wardens).get();

    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;

      hostelInfoList.clear();

      data.forEach((wardenUid, value) {
        final wardenData = value as Map<dynamic, dynamic>;

        if (wardenData['hostelName'] != null) {
          hostelInfoList.add({
            'hostelName': wardenData['hostelName'].toString(),
            'userUid': wardenData['userUid'].toString()

          });
          selectedUid.value = wardenUid;
          print(">>>>>>>$wardenData<<<<<<<<${wardenUid}>>>>>>>>>");
        }
      });
    }
  }

  // void getSelectedHostelUid() {
  //   final match = hostelInfoList.firstWhereOrNull((hostel) {
  //
  //    if( hostel['hostelName'] == selectedHostel.value){
  //      selectedUid.value = hostel['userUid']!;
  //      print(">>>>>>>>>>${selectedUid.value}<<<<<<");
  //
  //    }
  //  return true;
  //   });
  //   // return hostel['userUid'];
  // }


  Future<void> submitForm(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
// Generate a new push key
    final newRequestRef = db.ref.push();
    final newRequestKey = user.uid;
    final requestData = {
      'firstName': firstName.text.trim(),
      'lastName': lastName.text.trim(),
      'address': address.text.trim(),
      'phone': mobileNumber.text.trim(),
      'email': email.text.trim(),
      'education': education.text.trim(),
      'studentCount': selectedStudentCount.value,
      'hostelName': selectedHostel.value,
      'requestUid': newRequestKey,
      'userUid': user.uid,
      'timestamp': DateTime.now().toIso8601String(),
      'approvedStatus':false,
    };

    // Assuming you provide a UID for the request:
    // final pendingRequestId = db.child(FirebaseStrings.pendingRequests).push().key;

    await db
        .child(FirebaseStrings.pendingRequests)
        .child(selectedUid.value) // this is the hostel UID
        .child(newRequestKey) // this generates a unique key for each request
        .set(requestData);
    showDialog(
      context: context,
      builder: (_) =>  RegistrationSuccessPopup(),
    );
  }
}
