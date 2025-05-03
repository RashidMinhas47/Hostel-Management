import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_management/common/widgets/SizeWidgets/t_gap.dart';
import 'package:hostel_management/common/widgets/pending_card.dart';
import 'package:hostel_management/common/widgets/text/t_mid_title.dart';
import 'package:hostel_management/common/widgets/text/t_small_title.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/sizes.dart';

import '../controllers/warden_pending_ctr.dart';

class WardenPendingRequestScreen extends StatelessWidget {
  const WardenPendingRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WardenPendingRequestController());

    return Scaffold(
      backgroundColor: TColors.lightGrey,
      body: Stack(
        children: [
          // Top curved pink header
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 230,
                color: const Color(0xFFE57373),
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  children: const [
                    SizedBox(width: 8),
                    TTitleMid(label: "Pending Requests"),
                  ],
                ),
              ),
            ],
          ),

          // White curved container
          Container(
            margin: const EdgeInsets.only(top: 180),
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

              if (controller.pendingRequests.isEmpty) {
                return const Center(child: Text("No pending requests."));
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: controller.pendingRequests.length,
                itemBuilder: (context, index) {
                  final request = controller.pendingRequests[index];
                  return PendingRequestCard(
                    trailing:  TextButton(
                      onPressed: ()=>showDialog(
                        context: context,
                        builder: (_) =>  PendingRequestPopup(requestKey: request.userUid, name: "${request.firstName} ${request.lastName}",role: request.role,address: request.address,email: request.email,phone: request.phone,education: request.education,students: request.studentCount, hostelUid: controller.userUid.value, requestData: controller.pendingRequests.value[index].toMap(),),
                      ),

                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA726),

                      ),
                      child: const Text(
                        'Pending',
                        style: TextStyle(
                          color: TColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    name: request.firstName,
                    role: request.role,
                    institution: request.education,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}




class PendingRequestPopup extends StatelessWidget {
  const PendingRequestPopup({super.key, required this.name, required this.role, required this.address, required this.email, required this.phone, required this.education, required this.students, required this.requestKey, required this.hostelUid, required this.requestData});
  final String name;
  final String role;
  final String address;
  final String email;
  final String phone;
  final String education;
  final String students;
  final String requestKey;
  final String hostelUid;
  final Map<String, dynamic> requestData;


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WardenPendingRequestController());

    return AlertDialog(

      backgroundColor: TColors.white,
      title: const TTitleMid(label:"Pending Request Details",color: TColors.black,),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            TTitleSmall(label:"👤 Name: $name",color:TColors.black,fontWeight: FontWeight.w500,),
            Gap(y: TSizes.sm,),
            TTitleSmall(label:"🎓 Role: $role",color:TColors.black,fontWeight: FontWeight.w500,),
            Gap(y: TSizes.sm,),
            TTitleSmall(label:"📍 Address: $address",color:TColors.black,fontWeight: FontWeight.w500,),
            Gap(y: TSizes.sm,),
            TTitleSmall(label:"📧 Email: $email",color:TColors.black,fontWeight: FontWeight.w500,),
            Gap(y: TSizes.sm,),
            TTitleSmall(label:"📞 Phone: $phone",color:TColors.black,fontWeight: FontWeight.w500,),
            Gap(y: TSizes.sm,),
            TTitleSmall(label:"🎒 Education: $education",color:TColors.black,fontWeight: FontWeight.w500,),
            Gap(y: TSizes.sm,),
            TTitleSmall(label:"👥 Students: $students",color:TColors.black,fontWeight: FontWeight.w500,),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: TColors.lighterGrey
          ),
          onPressed:  () async {
          await controller.approveRequest(
          hostelUid: hostelUid,
          requestKey: requestKey,
          requestData: requestData,
          );
          Navigator.of(context).pop();
          },
          child:  Text("Approve", style: GoogleFonts.poppins(color: Colors.green)),
        ),
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: TColors.lighterGrey
          ),
          onPressed: () async {
            await controller.rejectRequest(
              hostelUid: hostelUid,
              requestKey: requestKey,
            );
            Navigator.of(context).pop();
          },
          child: Text("Reject", style: GoogleFonts.poppins(color: Colors.red)),
        ),
      ],
    );
  }
}
