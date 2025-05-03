import 'package:flutter/material.dart';
import 'package:hostel_management/common/widgets/appbar/appbar.dart';
import 'package:hostel_management/common/widgets/buttons/t_mid_button.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/sizes.dart';
import 'package:hostel_management/utils/devices/device_utility.dart';
import '../../../../../common/widgets/text/t_small_title.dart';

import '../../../../../common/widgets/SizeWidgets/t_gap.dart';
import '../../../../../common/widgets/buttons/t_large_button.dart';
import '../../../../../common/widgets/text_fields/t_text_fields.dart';
import 'package:get/get.dart';

import '../controllers/food_form_ctr.dart';


class FoodFormView extends StatelessWidget {
  const FoodFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodFormController());

    const Widget itemSpace = Gap(y: TSizes.spaceBtwItems);
    const Widget sectionSpace = Gap(y: TSizes.spaceBtwSections);

    return Scaffold(
      backgroundColor: TColors.action,
      appBar: TAppBar(
        showBackArrow: true,
        bgColor: TColors.action,
        title: TTitleSmall(label: "food complain"),
      ),
      body: Container(
        height: TDeviceUtils.getScreenHeight(context),
        width: TDeviceUtils.getScreenWidth(context),
        decoration: const BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sectionSpace,
              TTextField(
                controller: controller.emailController,
                icon: Icons.email_outlined,
                hintText: "email",
              ),
              sectionSpace,

              TTextField(
                controller: controller.messageController,
                icon: Icons.message_outlined,
                hintText: "Message",
                maxLines: 4,
              ),
              sectionSpace,

              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : TLargeButton(label: 'Send', onPressed: controller.sendComplaint)),

            ],
          ),
        ),
      ),
    );
  }
}
