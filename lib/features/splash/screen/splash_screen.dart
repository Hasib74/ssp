import 'package:employee_attendance_system/core/DI/depandancy_injection.dart';
import 'package:employee_attendance_system/core/theme/app_theme.dart';
import 'package:employee_attendance_system/data/repository/attendance_repository.dart';
import 'package:employee_attendance_system/features/attendance/controller/attandance_controller.dart';
import 'package:employee_attendance_system/features/auth/data/repository/auth_repository.dart';
import 'package:employee_attendance_system/generated/assets.dart';
import 'package:flutter/material.dart';

import '../../attendance/screen/attendance_screen.dart';
import '../../auth/screen/sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 3));

    AuthRepository authRepository = getIt<AuthRepository>();

    bool? _isSignIn = await authRepository.isSignIn();

    if (_isSignIn != null && _isSignIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const AttendanceScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const SignInScreen()));
    }

    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (_) => const SignInScreen()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor,
              AppTheme.secondaryColor,
            ],
          ),
        ),
        child: Center(
          child: Image(image: AssetImage(Assets.assetsLogo)),
        ),
      ),
    );
  }
}
