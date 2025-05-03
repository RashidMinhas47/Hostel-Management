import 'package:flutter/material.dart';
import 'package:hostel_management/common/widgets/appbar/appbar.dart';
import 'package:hostel_management/common/widgets/text/t_mid_title.dart';
import 'package:hostel_management/features/authentication/controllers/warden_signup_ctr.dart';
import 'package:hostel_management/features/warden_dashboard/home/warden_nav_menu.dart';
import 'package:hostel_management/navigation_menu.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/sizes.dart';
import 'package:hostel_management/utils/devices/device_utility.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/text/t_small_title.dart';

import '../../../../common/widgets/SizeWidgets/t_gap.dart';
import '../../../../common/widgets/buttons/t_large_button.dart';
import '../../../../common/widgets/text_fields/t_text_fields.dart';
import 'package:get/get.dart';

import '../../controllers/student_signup_ctr.dart';

import 'package:flutter/material.dart';
import 'package:hostel_management/common/widgets/appbar/appbar.dart';
import 'package:hostel_management/features/authentication/controllers/warden_signup_ctr.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/sizes.dart';
import 'package:hostel_management/utils/devices/device_utility.dart';
import 'package:hostel_management/utils/validators/validation.dart';
import '../../../../../common/widgets/text/t_small_title.dart';
import '../../../../common/widgets/SizeWidgets/t_gap.dart';
import '../../../../common/widgets/buttons/t_large_button.dart';
import '../../../../common/widgets/text_fields/t_text_fields.dart';
import 'package:get/get.dart';

// ... [imports remain the same]

class RegisterWardenScreen extends StatefulWidget {
  const RegisterWardenScreen({super.key});

  @override
  State<RegisterWardenScreen> createState() => _RegisterWardenScreenState();
}

class _RegisterWardenScreenState extends State<RegisterWardenScreen> {
  final controller = Get.put(RegisterWardenController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const Widget itemSpace = Gap(y: TSizes.spaceBtwItems);
    const Widget sectionSpace = Gap(y: TSizes.spaceBtwSections);

    return Scaffold(
      backgroundColor: TColors.action,
      appBar: TAppBar(
        bgColor: TColors.action,
        title: TTitleMid(label: "Details of Warden"),
      ),
      body: Container(
        height: TDeviceUtils.getScreenHeight(context),
        width: TDeviceUtils.getScreenWidth(context),
        decoration: const BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                sectionSpace,

                // First Name & Last Name
                Row(
                  children: [
                    Expanded(
                      child: TTextField(
                        icon: Iconsax.user,
                        hintText: "First Name",
                        controller: controller.firstNameController,
                        validator: (value) => TFormValidator.isNotEmpty(value, "First Name"),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const Gap(x: TSizes.spaceBtwItems),
                    Expanded(
                      child: TTextField(
                        icon: Iconsax.user,
                        hintText: "Last Name",
                        controller: controller.lastNameController,
                        validator: (value) => TFormValidator.isNotEmpty(value, "Last Name"),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ],
                ),

                itemSpace,

                // Address
                TTextField(
                  icon: Iconsax.location,
                  hintText: "Address",
                  controller: controller.addressController,
                  validator: (value) => TFormValidator.isNotEmpty(value, "Address"),
                  keyboardType: TextInputType.streetAddress,
                ),

                itemSpace,

                // Mobile Number
                TTextField(
                  icon: Iconsax.mobile,
                  hintText: "Mobile Number",
                  controller: controller.phoneController,
                  validator: TFormValidator.validatePhone,
                  keyboardType: TextInputType.phone,
                ),

                itemSpace,

                // Date
                TTextField(
                  icon: Iconsax.calendar,
                  hintText: "Date",
                  controller: controller.dateController,
                  validator: (value) => TFormValidator.isNotEmpty(value, "Date"),
                  keyboardType: TextInputType.datetime,
                ),

                itemSpace,

                // Hostel Name
                TTextField(
                  icon: Iconsax.building,
                  hintText: "Hostel Name",
                  controller: controller.hostelName,
                  validator: (value) => TFormValidator.isNotEmpty(value, "Hostel Name"),
                  keyboardType: TextInputType.text,
                ),

                itemSpace,

                // Email
                TTextField(
                  icon: Iconsax.direct_right,
                  hintText: "Email",
                  controller: controller.emailController,
                  validator: TFormValidator.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),

                itemSpace,

                // Password
                Obx(
                   () =>
                     TTextField(
                      icon: Iconsax.password_check,
                      hintText: "Password",
                      controller: controller.passwordController,
                      validator: TFormValidator.validatePassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.isChecked.value,
                      suffixIcon: IconButton(
                        onPressed: controller.isToggle,
                        icon: Icon(controller.isChecked.value ? Iconsax.eye: Iconsax.eye_slash,color: TColors.action,),
                      ),
                    )

                ),

                const Gap(y: TSizes.defaultSpace),

                // Register Button
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : TLargeButton(
                  label: 'Register',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.registerWarden();
                    }
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
