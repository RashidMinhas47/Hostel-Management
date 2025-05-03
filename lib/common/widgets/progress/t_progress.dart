import 'package:flutter/material.dart';

class TProgress extends StatelessWidget {
  const TProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 5,width:5,child: Center(child: CircularProgressIndicator()));
  }
}