import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management/common/widgets/progress/t_progress.dart';
import 'package:hostel_management/common/widgets/text/t_mid_title.dart';
import 'package:hostel_management/common/widgets/text/t_small_title.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/sizes.dart';
import 'package:hostel_management/utils/constants/image_strings.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/widgets/cards/student_card.dart';
import '../../student_dashboard/screens/home/views/notification_view.dart';
import '../controllers/warden_approved_ctr.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WardenApprovedRequestController());

    return Scaffold(
      backgroundColor: TColors.lighterGrey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            ListTile(
              leading: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(TImages.hostelBook, height: 10),
                ),
              ),
              title: const TTitleSmall(
                label: "Welcome",
                color: TColors.black,
                fontSize: TSizes.fontSizeSm,
                fontWeight: FontWeight.w400,
              ),
              subtitle: const TTitleSmall(
                label: "Warden",
                color: TColors.black,
                fontSize: TSizes.fontSizeMd,
              ),
              trailing: IconButton(
                style: IconButton.styleFrom(backgroundColor: TColors.lightGrey),
                onPressed: () => Get.to(const NotificationsScreen()),
                icon: const Icon(Iconsax.notification),
              ),
            ),

            // Section Title
            const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TTitleMid(label: "List of Approved Students", color: TColors.black, fontSize: TSizes.fontSizeLg),
            ),

            // Approved Students List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) return const TProgress();

                if (controller.approvedRequests.isEmpty) {
                  return const Center(child: Text("No approved students found."));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: controller.approvedRequests.length,
                  itemBuilder: (context, index) {
                    final student = controller.approvedRequests[index];
                    return StudentCard(
                      name: "${student.firstName} ${student.lastName}",
                      institution: student.education,
                      status: student.role,
                      imageUrl: TImages.appleLogo,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
