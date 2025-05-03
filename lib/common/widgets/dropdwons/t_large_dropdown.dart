import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';

class TLargeDropDown<T> extends StatelessWidget {
  const TLargeDropDown({
    super.key,
    this.value,
     this.hintText  = "Hostel Name",
    this.items,
    this.onChanged,
    this.icon,
  });

  final T? value;
  final String hintText;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: TColors.action),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          style: GoogleFonts.poppins(color: TColors.action),
          hint: Row(
            children: [
              Icon(icon, color: TColors.action),
              const SizedBox(width: 12),
              Text(hintText, style: TextStyle(color: TColors.action)),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          borderRadius: BorderRadius.circular(8),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
