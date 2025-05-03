import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management/common/widgets/text/t_mid_title.dart';
import 'package:hostel_management/utils/constants/colors.dart';

import '../../../../../common/widgets/appbar/appbar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.lightGrey,
      appBar: TAppBar(
        showBackArrow: true,
        bgColor: TColors.action,
        title: const TTitleMid(
         label: 'Notification',
        ),


      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: const [
          NotificationItem(
            color: Color(0xFF2196F3), // Blue
            timestamp: 'Now',
          ),
          NotificationItem(
            color: Color(0xFFFF9800), // Orange
            timestamp: 'Now',
          ),
          NotificationItem(
            color: Color(0xFFF48FB1), // Pink
            timestamp: 'Now',
            additionalText: 'Voluptate nisi',
          ),
          NotificationItem(
            color: Color(0xFF8BC34A), // Light Green
            timestamp: 'Now',
          ),
          NotificationItem(
            color: Color(0xFF26C6DA), // Cyan
            timestamp: 'Now',
          ),
          NotificationItem(
            color: Color(0xFFCDDC39), // Lime
            timestamp: 'Now',
          ),
          NotificationItem(
            color: Color(0xFF26A69A), // Teal
            timestamp: 'Now',
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final Color color;
  final String timestamp;
  final String? additionalText;

  const NotificationItem({
    Key? key,
    required this.color,
    required this.timestamp,
    this.additionalText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2.0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationIcon(color: color),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NotificationHeader(timestamp: timestamp),
                  const SizedBox(height: 4.0),
                  NotificationBody(additionalText: additionalText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  final Color color;

  const NotificationIcon({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.0,
      height: 44.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.notifications_outlined,
        color: Colors.white,
        size: 24.0,
      ),
    );
  }
}

class NotificationHeader extends StatelessWidget {
  final String timestamp;

  const NotificationHeader({
    Key? key,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Notificaties',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(
          timestamp,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.blue[400],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class NotificationBody extends StatelessWidget {
  final String? additionalText;

  const NotificationBody({
    Key? key,
    this.additionalText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseText = 'Aliqua officia duis occaecat consectetur fugiat nostrud anim dolor commodo officia proident.';
    String fullText = additionalText != null ? '$baseText $additionalText' : baseText;

    return Text(
      fullText,
      style: const TextStyle(
        fontSize: 14.0,
        color: Colors.black54,
        height: 1.4,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}