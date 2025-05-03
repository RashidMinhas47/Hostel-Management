import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management/common/widgets/appbar/appbar.dart';
import 'package:hostel_management/common/widgets/buttons/t_large_button.dart';
import 'package:hostel_management/common/widgets/dropdwons/t_large_dropdown.dart';
import 'package:hostel_management/common/widgets/text/t_small_title.dart';
import 'package:hostel_management/common/widgets/text_fields/t_text_fields.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/sizes.dart';
import 'package:hostel_management/utils/devices/device_utility.dart';
import 'package:hostel_management/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../../../common/widgets/SizeWidgets/t_gap.dart';
import '../controllers/hostel_booking_ctr.dart';

class HostelBookingScreen extends StatefulWidget {
  HostelBookingScreen({super.key});

  @override
  State<HostelBookingScreen> createState() => _HostelBookingScreenState();
}

class _HostelBookingScreenState extends State<HostelBookingScreen> {
  final controller = Get.put(HostelBookingController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const Widget itemSpace = Gap(y: TSizes.spaceBtwItems);
    const Widget sectionSpace = Gap(y: TSizes.spaceBtwSections);

    return Scaffold(
      backgroundColor: TColors.action,
      appBar: TAppBar(
        showBackArrow: true,
        bgColor: TColors.action,
        title: TTitleSmall(label: "Hostel booking detail"),
      ),
      body: Container(
        height: TDeviceUtils.getScreenHeight(context),
        width: TDeviceUtils.getScreenWidth(context),
        decoration: const BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  sectionSpace,
                  // Name + Last Name
                  Row(
                    children: [
                      Expanded(
                        child: TTextField(
                          validator:
                              (value) => TFormValidator.isNotEmpty(
                                value,
                                "First name",
                              ),
                          controller: controller.firstName,
                          icon: Icons.person_outline,
                          hintText: "First Name",
                        ),
                      ),
                      const Gap(x: TSizes.spaceBtwInputFields),
                      Expanded(
                        child: TTextField(
                          validator:
                              (value) =>
                                  TFormValidator.isNotEmpty(value, "Last name"),

                          controller: controller.lastName,
                          icon: Icons.person_outline,
                          hintText: "Last Name",
                        ),
                      ),
                    ],
                  ),
                  itemSpace,
                  TTextField(
                    validator:
                        (value) =>
                            TFormValidator.isNotEmpty(value, "Address name"),

                    controller: controller.address,
                    icon: Icons.pin_drop_outlined,
                    hintText: "Address",
                  ),
                  itemSpace,

                  // Hostel Selection Dropdown (from controller)
                  TLargeDropDown(
                    icon: Iconsax.home_2,
                    value:
                        controller.selectedHostel.value.isEmpty
                            ? null
                            : controller.selectedHostel.value,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.selectedHostel.value = newValue;
                        // controller.selectedUid.value = controller.getSelectedHostelUid()!;
                      }
                    },
                    items:
                        controller.hostelInfoList.map((hostelMap) {
                          if (controller.selectedHostel.value ==
                              hostelMap['hostelName']) {
                            controller.selectedUid.value =
                                hostelMap['userUid']!;
                            // controller.fetchHostelList();
                            print(
                              "...............${controller.selectedUid.value}............",
                            );
                          }
                          return DropdownMenuItem<String>(
                            value: hostelMap['hostelName'],
                            child: Text(hostelMap['hostelName'] ?? ''),
                          );
                        }).toList(),
                  ),

                  itemSpace,

                  // Student Count Dropdown
                  TLargeDropDown(
                    icon: Iconsax.personalcard,
                    value: controller.selectedStudentCount.value,
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        controller.selectedStudentCount.value = newValue;
                      }
                    },
                    items:
                        controller.studentCountOptions.map((int count) {
                          return DropdownMenuItem<int>(
                            value: count,
                            child: Text(
                              '$count ${count == 1 ? 'Student' : 'Students'}',
                            ),
                          );
                        }).toList(),
                  ),
                  itemSpace,
                  TTextField(
                    validator:
                        (value) =>
                            TFormValidator.isNotEmpty(value, "Mobile number"),

                    controller: controller.mobileNumber,
                    icon: Icons.phone_outlined,
                    hintText: "Mobile Number",
                  ),
                  itemSpace,
                  TTextField(
                    validator: (value) => TFormValidator.validateEmail(value),

                    controller: controller.email,
                    icon: Icons.email_outlined,
                    hintText: "Email",
                  ),
                  itemSpace,
                  TTextField(
                    validator:
                        (value) =>
                            TFormValidator.isNotEmpty(value, "Education"),

                    controller: controller.education,
                    icon: Icons.cast_for_education,
                    hintText: "Education",
                  ),
                  const Gap(y: TSizes.defaultSpace),
                  // Register Button
                  TLargeButton(
                    label: 'Register',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (controller.selectedHostel.value.isEmpty) {
                          Get.snackbar("Hostel Required", "Please select a hostel.");
                          return;
                        }

                        if (controller.selectedStudentCount.value == 0) {
                          Get.snackbar("Student Count", "Please select number of students.");
                          return;
                        }

                        controller.submitForm(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
