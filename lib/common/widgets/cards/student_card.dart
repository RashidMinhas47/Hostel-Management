import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../text/t_small_title.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final String institution;
  final String status;
  final String imageUrl;

  const StudentCard({
    super.key,
    required this.name,
    required this.institution,
    required this.status,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            // child: Icon(Icons.person,size: 35,),
            backgroundImage: AssetImage(imageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TTitleSmall(label: name, color: TColors.black, fontWeight: FontWeight.w600),
                TTitleSmall(label: institution.toUpperCase(), color: TColors.darkGrey,fontWeight: FontWeight.w900,),
                TTitleSmall(label: status, color: Colors.green),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: TColors.green.withOpacity(0.6),

            ),
            child: TTitleSmall(label:"Approved"),
          )
        ],
      ),
    );
  }
}
