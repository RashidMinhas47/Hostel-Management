import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management/common/widgets/appbar/appbar.dart';
import 'package:hostel_management/navigation_menu.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/sizes.dart';
import 'package:hostel_management/utils/devices/device_utility.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/text/t_small_title.dart';
import '../../../../common/widgets/SizeWidgets/t_gap.dart';
import '../../../../common/widgets/buttons/t_large_button.dart';
import '../../../../common/widgets/text/t_mid_title.dart';
import '../../../../common/widgets/text_fields/t_text_fields.dart';
import '../../../../common/widgets/dropdwons/t_large_dropdown.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/student_signup_ctr.dart';

class RegisterStudentScreen extends StatefulWidget {
  const RegisterStudentScreen({super.key});

  @override
  State<RegisterStudentScreen> createState() => _RegisterStudentScreenState();
}

class _RegisterStudentScreenState extends State<RegisterStudentScreen> {
  final controller = Get.put(RegisterStudentController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const Widget itemSpace = Gap(y: TSizes.spaceBtwItems);
    const Widget sectionSpace = Gap(y: TSizes.spaceBtwSections);

    return Scaffold(
      backgroundColor: TColors.action,
      appBar: TAppBar(
        bgColor: TColors.action,
        title: TTitleMid(label: "Details of Student"),
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
                // Hostel selection
                Obx(() => TLargeDropDown<String>(
                  icon: Iconsax.home_2,
                  value: controller.selectedHostel.value.isEmpty ? null : controller.selectedHostel.value,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedHostel.value = newValue;
                      final match = controller.hostelInfoList.firstWhere(
                        (h) => h['hostelName'] == newValue,
                        orElse: () => {},
                      );
                      if (match.isNotEmpty) {
                        controller.selectedUid.value = match['userUid'] ?? '';
                      }
                    }
                  },
                  items: controller.hostelInfoList
                      .map((hostelMap) => DropdownMenuItem<String>(
                            value: hostelMap['hostelName'],
                            child: Text(hostelMap['hostelName'] ?? ''),
                          ))
                      .toList(),
                )),
                itemSpace,
                // Student count
                Obx(() => TLargeDropDown<int>(
                  icon: Iconsax.personalcard,
                  value: controller.selectedStudentCount.value,
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      controller.selectedStudentCount.value = newValue;
                    }
                  },
                  items: controller.studentCountOptions
                      .map((count) => DropdownMenuItem<int>(
                            value: count,
                            child: Text('$count ${count == 1 ? 'Student' : 'Students'}'),
                          ))
                      .toList(),
                )),
                itemSpace,
                // Education
                TTextField(
                  icon: Iconsax.text,
                  hintText: "Education",
                  controller: controller.educationController,
                  validator: (value) => TFormValidator.isNotEmpty(value, "Education"),
                  keyboardType: TextInputType.text,
                ),
                itemSpace,
                TTextField(
                  icon: Iconsax.location,
                  hintText: "Address",
                  controller: controller.addressController,
                  validator: (value) => TFormValidator.isNotEmpty(value, "Address"),
                  keyboardType: TextInputType.streetAddress,
                ),
                itemSpace,
                TTextField(
                  icon: Iconsax.mobile,
                  hintText: "Mobile Number",
                  controller: controller.phoneController,
                  validator: TFormValidator.validatePhone,
                  keyboardType: TextInputType.phone,
                ),
                itemSpace,
                TTextField(
                  icon: Iconsax.calendar,
                  hintText: "Date",
                  controller: controller.dateController,
                  validator: (value) => TFormValidator.isNotEmpty(value, "Date"),
                  keyboardType: TextInputType.datetime,
                ),
                itemSpace,
                TTextField(
                  icon: Iconsax.direct_right,
                  hintText: "Email",
                  controller: controller.emailController,
                  validator: TFormValidator.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                itemSpace,
                Obx(
                   () =>
                     TTextField(
                      icon: Iconsax.password_check4,
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
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : TLargeButton(
                  label: 'Register',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.registerStudent();
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
