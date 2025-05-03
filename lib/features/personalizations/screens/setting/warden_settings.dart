import 'package:hostel_management/common/widgets/SizeWidgets/t_gap.dart';
import 'package:hostel_management/common/widgets/buttons/t_large_button.dart';
import 'package:hostel_management/common/widgets/cards/profile_info_card.dart';
import 'package:hostel_management/common/widgets/text/t_mid_title.dart';
import 'package:hostel_management/common/widgets/text_fields/t_text_fields.dart';
import 'package:hostel_management/features/authentication/controllers/warden_ctr.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../authentication/controllers/student_ctr.dart';
import 'package:get/get.dart';

class WardenSettings extends StatefulWidget {
  const WardenSettings({super.key});

  @override
  State<WardenSettings> createState() => _WardenSettingsState();
}

class _WardenSettingsState extends State<WardenSettings> {
  final WardenCtr controller = Get.put(WardenCtr());
  bool eyeCheck = true;

  final _formKey = GlobalKey<FormState>();

  final _firstName = TextEditingController();

  final _lastName = TextEditingController();

  final _address = TextEditingController();

  final _phone = TextEditingController();

  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const gap = Gap(y: TSizes.spaceBtwItems);

    return Scaffold(
      backgroundColor: TColors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final student = controller.student.value;

        if (student == null) {
          return const Center(child: Text("No student data found"));
        }

        _firstName.text = student.firstName;
        _lastName.text = student.lastName;
        _address.text = student.address;
        _phone.text = student.phone;
        _password.text = student.password;
        return Stack(
          children: [
            // Header Section
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 140,
                  color: const Color(0xFFE57373),
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Iconsax.arrow_left,
                          color: TColors.white,
                        ),
                        onPressed: () => Get.back(),
                      ),
                      const SizedBox(width: 8),
                      const TTitleMid(label: 'profile detail'),
                    ],
                  ),
                ),
              ],
            ),

            // Curved White Content Area
            Container(
              margin: const EdgeInsets.only(top: 120),
              decoration: const BoxDecoration(
                color: TColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // First name and last name row
                        Row(
                          children: [
                            Expanded(
                              child: TTextField(
                                icon: Iconsax.user,
                                controller: _firstName,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TTextField(
                                icon: Iconsax.user,
                                controller: _lastName,
                              ),
                            ),
                          ],
                        ),
                        gap,
                        // Address field
                        TTextField(
                          icon: Iconsax.location,
                          controller: _address,
                        ),
                        gap,
                        // Phone number field
                        TTextField(icon: Iconsax.mobile, controller: _phone),
                        gap,
                        // Date field
                        ProfileInfoCard(
                          icon: Iconsax.calendar,
                          iconColor: TColors.action,
                          value: controller.student.value?.date ?? "Not Loaded",
                        ),
                        gap,
                        // Email field
                        ProfileInfoCard(
                          icon: Iconsax.direct_right,
                          iconColor: TColors.action,
                          value:
                              controller.student.value?.email ?? "Not Loaded",
                        ),
                        gap,
                        // ID field
                        TTextField(
                          icon: Iconsax.password_check,
                          controller: _password,
                          obscureText: controller.isChecked.value,
                          suffixIcon: IconButton(
                            onPressed: controller.isToggle,
                            icon: Icon(controller.isChecked.value ? Iconsax.eye:Iconsax.eye_slash,color: TColors.action, ),
                          ),
                        ),
                        const Gap(y: TSizes.spaceBtwSections),

                        // Back to profile button
                        TLargeButton(
                          label: "Save Changes",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final updated = student.copyWith(
                                firstName: _firstName.text.trim(),
                                lastName: _lastName.text.trim(),
                                address: _address.text.trim(),
                                phone: _phone.text.trim(),
                                password: _password.text.trim(),
                              );
                              controller.updateWarden(updated);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
