import 'package:hostel_management/common/styles/spacing_styles.dart';
import 'package:hostel_management/features/authentication/screens/login/widgets/login_form.dart';
import 'package:hostel_management/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_ctr.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Logo Title & subtitle
              TLoginHeader(),
              ///Form
              TLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}





