import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/sizes.dart';
import 'package:hostel_management/utils/devices/device_utility.dart';
import '../../../../../common/widgets/text/t_small_title.dart';

class TMidButton extends StatelessWidget {
  const TMidButton({
    super.key, required this.label, required this.onPressed,
  });
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(TDeviceUtils.getScreenWidth(context)*0.7, 50),
        backgroundColor: TColors.action,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 32,
        ),
      ),
      onPressed: onPressed,
      child:  TTitleSmall(label: label),
    );
  }
}

