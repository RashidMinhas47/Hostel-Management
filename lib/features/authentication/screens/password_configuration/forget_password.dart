import 'package:hostel_management/common/widgets/buttons/t_large_button.dart';
import 'package:hostel_management/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:hostel_management/utils/constants/sizes.dart';
import 'package:hostel_management/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/forgot_password_ctr.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Heading
           Text(TTexts.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(TTexts.forgetPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwItems *2),

            ///TextField


            TextFormField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct_right)
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            


            ///Submit Button
            ///
            Obx(() =>controller.isLoading.value ? CircularProgressIndicator() : TLargeButton(label: "Submit", onPressed:  controller.sendPasswordResetEmail)

            ),          ],
        ),
      ),
    );
  }
}
