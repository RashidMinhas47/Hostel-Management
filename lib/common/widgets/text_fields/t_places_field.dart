import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:iconsax/iconsax.dart';
import 'package:hostel_management/utils/constants/colors.dart';
import 'package:hostel_management/utils/constants/api_keys.dart';

class TPlacesField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String, double, double) onLocationSelected;

  const TPlacesField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.validator,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TColors.grey),
        boxShadow: [
          BoxShadow(
            color: TColors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: ApiKeys.googlePlacesApiKey,
        inputDecoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: TColors.action),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        debounceTime: 400,
        countries: const ["pk"], // Pakistan - you can change this
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          print("Place Details: ${prediction.description}");
          print("Latitude: ${prediction.lat}");
          print("Longitude: ${prediction.lng}");

          // Call the callback with the selected location data
          onLocationSelected(
            prediction.description ?? "",
            double.tryParse(prediction.lat ?? "0") ?? 0.0,
            double.tryParse(prediction.lng ?? "0") ?? 0.0,
          );
        },
        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: prediction.description?.length ?? 0),
          );
        },
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: TColors.action),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    prediction.description ?? "",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        },
        seperatedBuilder: const Divider(),
        containerHorizontalPadding: 10,
        validator: (value, context) => validator?.call(value),
      ),
    );
  }
}
