import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostel_management/decider_screen.dart';
import 'package:hostel_management/features/authentication/screens/signup/sign_up_student.dart';
import 'package:hostel_management/features/authentication/screens/signup/verify_email.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(App());
  
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: DeciderScreen(),
    );
  }
}
