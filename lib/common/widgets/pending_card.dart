import 'package:flutter/material.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/image_strings.dart';

import '../../features/warden_dashboard/screens/warden_pending_requests.dart';

class PendingRequestCard extends StatelessWidget {
  final String name;
  final String role;
  final String institution;
  final Widget trailing;
  // final VoidCallback onPressed;
  // final String imageUrl;

  const PendingRequestCard({
    super.key,
    required this.name,
    required this.role,
    required this.institution,   required this.trailing,
    // required this.onPressed,
    // required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 15/6,
      child: SizedBox(
        height: 140,
        child: Card(

          color: TColors.white,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Profile image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    TImages.appleLogo,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 100,
                        color: TColors.lightGrey,
                        child: const Icon(Icons.person, size: 50, color: TColors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // User info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        role,
                        style: TextStyle(
                          fontSize: 14,
                          color: TColors.darkGrey,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        institution,
                        style: TextStyle(
                          fontSize: 14,
                          color: TColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Pending button
                trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}