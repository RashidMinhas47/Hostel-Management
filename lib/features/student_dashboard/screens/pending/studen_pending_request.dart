import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management/common/widgets/appbar/appbar.dart';
import 'package:hostel_management/common/widgets/pending_card.dart';
import 'package:hostel_management/common/widgets/text/t_mid_title.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/sizes.dart';
import '../../../../common/widgets/SizeWidgets/t_gap.dart';
import '../../../../common/widgets/text/t_small_title.dart';
import '../../controllers/student_pending_request_ctr.dart';

class StudentPendingRequestScreen extends StatelessWidget {
  const StudentPendingRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentPendingRequestController());

    return Scaffold(
      appBar: TAppBar(
        bgColor: TColors.action,
        title: TTitleMid(label: "Your Requests"),
      ),
      backgroundColor: TColors.lightGrey,
      body: Column(
        children: [
          /// Content container
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: TColors.lightGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final pending = controller.pendingRequests;
                final approved = controller.approvedRequests;

                final hasPending = pending.isNotEmpty;
                final hasApproved = approved.isNotEmpty;

                if (!hasPending && !hasApproved) {
                  return const Center(child: Text("No requests available"));
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hasPending) ...[
                        const Gap(y: TSizes.spaceBtwItems),
                        const TTitleMid(
                          label: "Pending Requests",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: TColors.black,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: pending.length,
                            itemBuilder: (context, index) {
                              final request = pending[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: PendingRequestCard(
                                  name: request.fullName ?? 'N/A',
                                  role: request.role ?? 'N/A',
                                  institution: request.education ?? 'N/A',
                                  trailing: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: TColors.secondary.withOpacity(1),
                                    ),
                                    child: const TTitleSmall(label: "Pending"),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],

                      if (hasApproved) ...[
                        const Gap(y: TSizes.spaceBtwSections),
                        const TTitleMid(
                          label: "Approved Requests",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: TColors.black,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: approved.length,
                            itemBuilder: (context, index) {
                              final request = approved[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: PendingRequestCard(
                                  name: request.fullName ?? 'N/A',
                                  role: request.role ?? 'N/A',
                                  institution: request.education ?? 'N/A',
                                  trailing: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: TColors.green.withOpacity(0.6),
                                    ),
                                    child: const TTitleSmall(label: "Approved"),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
