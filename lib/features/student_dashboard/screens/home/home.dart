import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management/features/authentication/controllers/student_ctr.dart';
import 'package:hostel_management/features/student_dashboard/screens/home/views/food_form_view.dart';
import 'package:hostel_management/features/student_dashboard/screens/home/views/help_center.dart';
import 'package:hostel_management/features/student_dashboard/screens/home/views/hostel_booking.dart';
import 'package:hostel_management/features/student_dashboard/screens/home/views/notification_view.dart';
import 'package:hostel_management/features/student_dashboard/screens/home/views/outing_view.dart';
import '../../../../../common/widgets/text/t_small_title.dart';

import '../../../../common/widgets/buttons/t_mid_button.dart';
import '../../../../common/widgets/progress/t_progress.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stdCtr = Get.put(StudentController());
    return  SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(TImages.hostelBook, height: 10),
                ),
              ),
              title: TTitleSmall(
                label: "Welcome",
                color: TColors.black,
                fontSize: TSizes.fontSizeSm,
                fontWeight: FontWeight.w400,
              ),
              subtitle: Obx(
                 () {
                  return stdCtr.isLoading.value ? TProgress(): TTitleSmall(
                    label: stdCtr.student.value?.firstName ?? "Not Loaded",
                    color: TColors.black,
                    fontSize: TSizes.fontSizeMd,
                  );
                }
              ),
              trailing: IconButton(style: IconButton.styleFrom(
                  backgroundColor: TColors.lightGrey
              ), onPressed: ()=>Get.to(NotificationsScreen()), icon: Icon(Icons.notifications)),
            ),

            // Grid of icon-text blocks
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildIconTextBlock(onTap: ()=> Get.to(()=>FoodFormView()), 'FOOD',  TImages.food),
                  _buildIconTextBlock(onTap: ()=> Get.to(()=>HostelBookingScreen()),'HOSTEL BOOKING', TImages.hostelBook),
                  _buildIconTextBlock(onTap: ()=> Get.to(()=>HelpFormView()),'HELP CENTER', TImages.helpCenter),
                  _buildIconTextBlock(onTap: ()=> Get.to(()=>OutingFormView()),'OUTINGS/LEAVE', TImages.leaving),
                ],
              ),
            ),
            // Bottom Navigation Bar
          ],
        ),
      ),
    );
  }
  Widget _buildIconTextBlock(String label, String imagePath,{required VoidCallback onTap}) {
    return Card(
      color: TColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap:onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 100),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


