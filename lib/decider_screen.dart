import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hostel_management/features/authentication/controllers/warden_signup_ctr.dart';
import 'package:hostel_management/features/authentication/screens/onboarding/onboarding.dart';
import 'features/warden_dashboard/home/warden_nav_menu.dart';
import 'navigation_menu.dart';
import 'features/student_dashboard/screens/pending/studen_pending_request.dart';

class DeciderScreen extends StatefulWidget {
  const DeciderScreen({super.key});

  @override
  State<DeciderScreen> createState() => _DeciderScreenState();
}

class _DeciderScreenState extends State<DeciderScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instanceFor(
    databaseURL:
        'https://hostel-management-9b5cc-default-rtdb.asia-southeast1.firebasedatabase.app',
    app: Firebase.app(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserAndNavigate();
    });
  }

  Future<void> _checkUserAndNavigate() async {
    final user = _auth.currentUser;

    if (user == null) {
      Get.offAll(() => const OnboardScreen());
      return;
    }

    final uid = user.uid;

    final studentRef = _database.ref('${FirebaseStrings.students}/$uid');
    final wardenRef = _database.ref('${FirebaseStrings.wardens}/$uid');

    final studentSnapshot = await studentRef.get();
    if (studentSnapshot.exists) {
      // If student exists, check if there is an approved request for this user
      final approvedRef = _database.ref(FirebaseStrings.approvedRequests);
      final approvedSnap = await approvedRef.get();
      bool isApproved = false;
      if (approvedSnap.exists) {
        final approvedMap = approvedSnap.value as Map<dynamic, dynamic>;
        approvedMap.forEach((wardenUid, requestsMap) {
          if (requestsMap is Map && requestsMap[uid] != null) {
            isApproved = true;
          }
        });
      }

      if (isApproved) {
        Get.offAll(() => const StudentNavigationMenu());
      } else {
        // Pending state: send to pending requests screen so the student can see status
        Get.offAll(() => const StudentPendingRequestScreen());
      }
      return;
    }

    final wardenSnapshot = await wardenRef.get();
    if (wardenSnapshot.exists) {
      Get.offAll(() => const WardenNavigationMenu());
      return;
    }

    // fallback
    Get.offAll(() => const OnboardScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
