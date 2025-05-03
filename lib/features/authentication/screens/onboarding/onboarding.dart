import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_management/features/authentication/screens/login/login.dart';
import 'package:hostel_management/features/authentication/screens/signup/sign_up_student.dart';
import 'package:hostel_management/features/authentication/screens/signup/signup_as_warden.dart';
import 'package:hostel_management/features/student_dashboard/screens/home/views/hostel_booking.dart';
import 'package:hostel_management/utils/constants/image_strings.dart';
import 'package:hostel_management/utils/constants/sizes.dart';
import 'package:hostel_management/utils/devices/device_utility.dart';

import '../../../../common/widgets/buttons/t_mid_button.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../../common/widgets/text/t_small_title.dart';

import 'package:get/get.dart';
class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TTitleSmall(
                  label:'LETS GET ONBOARD !!',
               color: TColors.black,
                ),
                const SizedBox(height: 32),
                Image.asset(
                  TImages.rocket, // 🔁 Replace with your image path
                  height: 200,
                ),
                const SizedBox(height: 48),
                TMidButton(label: "Signup as student",onPressed: ()=>Get.to(()=>RegisterStudentScreen()),),
                const SizedBox(height: 16),
                TMidButton(label: "Signup as warden",onPressed: ()=>Get.to(()=>RegisterWardenScreen()),),
AlreadyHaveAccountLogin(onTap: ()=>Get.to(()=>LoginScreen()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class AlreadyHaveAccountLogin extends StatelessWidget {
  final VoidCallback onTap;
  final Color textColor;
  final Color linkColor;
  final double fontSize;
  final FontWeight textFontWeight;
  final FontWeight linkFontWeight;

  const AlreadyHaveAccountLogin({
    Key? key,
    required this.onTap,
    this.textColor = Colors.black54,
    this.linkColor = Colors.blue,
    this.fontSize = 14.0,
    this.textFontWeight = FontWeight.normal,
    this.linkFontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: textFontWeight,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'Login',
              style: TextStyle(
                color: linkColor,
                fontSize: fontSize,
                fontWeight: linkFontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

