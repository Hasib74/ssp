import 'package:employee_attendance_system/core/theme/app_theme.dart';
import 'package:employee_attendance_system/core/utls/app_spaces.dart';
import 'package:employee_attendance_system/core/widgets/app_text_filed.dart';
import 'package:employee_attendance_system/features/attendance/screen/attendance_screen.dart';
import 'package:employee_attendance_system/features/auth/controller/auth_controller.dart';
import 'package:employee_attendance_system/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/DI/depandancy_injection.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(Assets.assetsGovtLogo),
                      AppSpaces.spaceHeight15,
                      Text(
                        "Surveillance and Security for\n 85 Sarkari Shishu Paribar (SSP)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpaces.spaceHeight15,
                AppSpaces.spaceHeight15,
                Form(
                    key: getIt<AuthController>().fromKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: AppTextFiled(
                            autofocus: true,
                            //controller: TextEditingController(),

                            context: context,

                            controller:
                                getIt<AuthController>().userIdController,

                            hint: "User Id",
                            label: "User ID",

                            isRequired: true,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                        ),
                        AppSpaces.spaceHeight15,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: AppTextFiled(
                            context: context,

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password can not be empty';
                              }
                              return null;
                            },
                            controller:
                                getIt<AuthController>().passwordController,
                            // controller: TextEditingController(),
                            hint: "Password",
                            label: "Password",
                            isRequired: true,

                            isObscure: true,
                            onFieldSubmitted: (value) {
                              getIt<AuthController>().signIn(context);
                            },
                          ),
                        ),
                      ],
                    )),
                AppSpaces.spaceHeight15,
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        getIt<AuthController>().signIn(context);
                      },
                      child: const Center(child: Text("Sign In"))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
