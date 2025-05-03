import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;

  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: TColors.lightGrey),
        boxShadow: [
          BoxShadow(
            color: TColors.lightGrey,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: TColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
