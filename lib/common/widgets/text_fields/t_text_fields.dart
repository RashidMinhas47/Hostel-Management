import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/colors.dart';

class TTextField extends StatelessWidget {
  const TTextField({
    super.key, this.hintText, this.controller, this.icon,this.maxLines =1,  this.validator, this.keyboardType, this.obscureText = false, this.suffixIcon,
  });

  final String? hintText;
  final TextEditingController? controller;
  final IconData? icon;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
final TextInputType? keyboardType;
final bool? obscureText;
final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),

      child: TextFormField(

        obscureText: obscureText!,
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines,
        style: GoogleFonts.poppins(

        ),
        controller: controller,

        decoration: InputDecoration(

errorStyle: GoogleFonts.poppins(),

          prefixIcon: Icon(icon, color: TColors.action),
          suffixIcon: suffixIcon,

          hintText: hintText,

          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintStyle: const TextStyle(fontSize: 14),

        ),
      ),
    );
  }
}

