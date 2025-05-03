import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_management/common/widgets/buttons/t_large_button.dart';
import 'package:hostel_management/common/widgets/text/t_mid_title.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/sizes.dart';

import '../../controllers/email_confirmation_ctr.dart';

class EmailConfirmationScreen extends StatelessWidget {
  const EmailConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailConfirmationController());

    return Scaffold(
      appBar: AppBar(title: const TTitleMid(label:'Verify Your Email'),backgroundColor: TColors.action,),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'We’ve sent a confirmation email to:',
              style: GoogleFonts.poppins(fontSize: TSizes.fontSizeLg),
            ),
            const SizedBox(height: 12),
            Text(
              "Email: ${controller.email.value}",
              style:  GoogleFonts.poppins(fontSize: TSizes.fontSizeMd, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TLargeButton(
              onPressed:() => controller.isSending.value ? null : controller.sendVerificationEmail,
              label: controller.isSending.value
                  ? 'Sending...'
                  : 'Resend Email',
            ),
            const SizedBox(height: 24),
            TLargeButton(
              onPressed: controller.checkEmailVerified,
              label: 'Continue',
            ),
            const SizedBox(height: 16),
            if (controller.isVerified.value)
              const Text('✅ Email Verified! You may proceed.', style: TextStyle(color: Colors.green)),
          ],
        )),
      ),
    );
  }
}
