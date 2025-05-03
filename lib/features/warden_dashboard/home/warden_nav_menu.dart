// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:hostel_management/features/personalizations/screens/profile/student_profile.dart';
import 'package:hostel_management/features/personalizations/screens/profile/warden_profile.dart';
import 'package:hostel_management/features/student_dashboard/screens/pending/studen_pending_request.dart';
import 'package:hostel_management/features/warden_dashboard/screens/approved_std_screen.dart';
import 'package:hostel_management/features/warden_dashboard/screens/warden_pending_requests.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/image_strings.dart';
import 'package:iconsax/iconsax.dart';

import '../../student_dashboard/screens/home/home.dart';

class WardenNavigationMenu extends StatefulWidget {
  const WardenNavigationMenu({super.key});

  @override
  State<WardenNavigationMenu> createState() => _WardenNavigationMenuState();
}

class _WardenNavigationMenuState extends State<WardenNavigationMenu> {
  int currentIndex = 0;
  List<Widget> screens = [
    StudentListScreen(),
WardenPendingRequestScreen(),    WardenProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: Stack(
        children: [
          screens.elementAt(currentIndex),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // Reusable widget for icon and text block
}

class TNavBar extends StatelessWidget {
  const TNavBar({super.key, required this.currentIndex, required this.onTap});
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12), // Adds spacing from screen edges
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4), // Moves the shadow down a bit
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(

          onTap: onTap,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          elevation: 0, // Remove default shadow since we use BoxShadow
          backgroundColor: TColors.white,
          selectedItemColor: TColors.action,
          unselectedItemColor: Colors.grey.shade400,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.profile_tick),
              label: 'Hostel Student',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.personalcard),
              label: 'Pending',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.setting),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
