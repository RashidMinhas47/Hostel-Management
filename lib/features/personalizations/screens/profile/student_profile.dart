import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:hostel_management/common/widgets/text/t_mid_title.dart";
import "package:hostel_management/features/personalizations/screens/setting/student_settings.dart";
import "package:iconsax/iconsax.dart";
import "../../../../common/widgets/appbar/appbar.dart";
import "../../../authentication/controllers/student_ctr.dart";
import "../../../authentication/controllers/student_signup_ctr.dart";

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key, required this.userName, required this.imageUrl,});
  final String userName;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterStudentController());
    final StudentController stdCtr = Get.put(StudentController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TAppBar(
        bgColor: const Color(0xFFE57373),
        title: TTitleMid(label: "Profile"),

      ),
      body: Column(
        children: [
          // Profile header section
          Container(
            color: const Color(0xFFE57373),
            padding: const EdgeInsets.only(bottom: 20),
            child:  Center(
              child: Obx(
                 () {
                 return controller.isLoading.value ?  CircularProgressIndicator():  ProfileAvatar(
                    imageUrl: imageUrl,
                    username: stdCtr.student.value?.firstName ?? "Not Loaded",
                  );
                }
              ),
            ),
          ),

          // Profile action buttons
          const SizedBox(height: 20),
           ProfileActionButton(
            onTap: ()=> Get.to(()=>StudentProfileDetails()),
            icon: Iconsax.user,
            iconColor: Colors.white,
            backgroundColor: Color(0xFF8BC34A),
            title: 'My profile',
          ),
          const Divider(height: 1),

                ProfileActionButton(
                 onTap: controller.logout,
                icon: Iconsax.logout,
                iconColor: Colors.white,
                backgroundColor: Color(0xFFEC407A),
                title: 'Logout',


          ),
        ],
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final String username;

  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.pink[50],
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: ClipOval(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Iconsax.user, size: 40, color: Colors.grey);
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        TTitleMid(
          label:username,
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,

        ),

      ],
    );
  }
}

class ProfileActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final VoidCallback? onTap;

  const ProfileActionButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}