import 'package:employee_attendance_system/core/theme/app_theme.dart';
import 'package:employee_attendance_system/features/attendance/screen/attendance_screen.dart';
import 'package:employee_attendance_system/features/auth/screen/sign_in.dart';
import 'package:employee_attendance_system/features/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/DI/depandancy_injection.dart';

void main() async {
  await setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      title: 'Flutter Demo',
      theme: AppTheme.getTheme(),
      home: const SplashScreen(),
    );
  }
}
