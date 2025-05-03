import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TTitleMid extends StatelessWidget {
  const TTitleMid({
    super.key,
    required this.label,this.color= TColors.white,this.fontWeight = FontWeight.w900, this.fontSize = TSizes.fontSizeMd

  });

  final String label;
  final FontWeight? fontWeight;
  final double? fontSize;

  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
          fontWeight: fontWeight,
          color:color,
          fontSize: fontSize,
          letterSpacing: 1
      ),
    );
  }
}