import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../warden_dashboard/controllers/warden_approved_ctr.dart';

class StudentPendingRequestController extends GetxController {
  var pendingRequests = <RequestModel>[].obs;
  var approvedRequests = <RequestModel>[].obs;
  var isLoading = true.obs;

  final _dbRef = FirebaseDatabase.instance.ref();
  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    fetchRequests();
    super.onInit();
  }

  void fetchRequests() async {
    try {
      isLoading.value = true;
      final userUid = _auth.currentUser?.uid;

      if (userUid == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      // Fetch pending requests
      final pendingSnap = await _dbRef.child("PendingRequests").get();
      final List<RequestModel> fetchedPending = [];

      if (pendingSnap.exists) {
        final pendingMap = pendingSnap.value as Map<dynamic, dynamic>;

        pendingMap.forEach((wardenUid, requestsMap) {
          if (requestsMap[userUid] != null) {
            final requestData = requestsMap[userUid];
            final request = RequestModel.fromMap(requestData);
            fetchedPending.add(request);
          }
        });
      }

      // Fetch approved requests
      final approvedSnap = await _dbRef.child("ApprovedRequests").get();
      final List<RequestModel> fetchedApproved = [];

      if (approvedSnap.exists) {
        final approvedMap = approvedSnap.value as Map<dynamic, dynamic>;

        approvedMap.forEach((wardenUid, requestsMap) {
          if (requestsMap[userUid] != null) {
            final requestData = requestsMap[userUid];
            final request = RequestModel.fromMap(requestData);
            fetchedApproved.add(request);
          }
        });
      }

      pendingRequests.value = fetchedPending;
      approvedRequests.value = fetchedApproved;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch requests: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
