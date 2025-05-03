import 'package:get_storage/get_storage.dart';
import 'package:hostel_management/common/widgets/buttons/t_large_button.dart';
import 'package:hostel_management/common/widgets/text/t_mid_title.dart';
import 'package:hostel_management/common/widgets/text_fields/t_text_fields.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/cards/profile_info_card.dart';
import '../../../authentication/controllers/student_ctr.dart';
import 'package:get/get.dart';

class StudentProfileDetails extends StatelessWidget {
  StudentProfileDetails({super.key});
  final StudentController controller = Get.put(StudentController());

  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                          Icons.arrow_back,
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
                                icon: Icons.person,
                                controller: _firstName,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TTextField(
                                icon: Icons.person,
                                controller: _lastName,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Address field
                        TTextField(
                          icon: Icons.location_pin,
                          controller: _address,
                        ),
                        const SizedBox(height: 16),

                        // Phone number field
                        TTextField(icon: Icons.phone, controller: _phone),
                        const SizedBox(height: 16),

                        // Date field
                        ProfileInfoCard(
                          icon: Icons.calendar_today,
                          iconColor: TColors.action,
                          value: controller.student.value?.date ?? "Not Loaded",
                        ),
                        const SizedBox(height: 16),

                        // Email field
                        ProfileInfoCard(
                          icon: Icons.email,
                          iconColor: TColors.action,
                          value:
                              controller.student.value?.email ?? "Not Loaded",
                        ),
                        const SizedBox(height: 16),

                        // ID field
                        TTextField(
                          icon: Icons.lock,
                          controller: _password,
                          obscureText: controller.isChecked.value,
                          suffixIcon: IconButton(
                            onPressed: controller.isToggle,
                            icon: Icon(Icons.remove_red_eye),
                          ),
                        ),

                        const SizedBox(height: 40),

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
                              controller.updateStudent(updated);
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

