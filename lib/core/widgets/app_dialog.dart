import 'package:employee_attendance_system/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class AppDialog {
  static noInternetDialog({required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        builder: (_) {
          return GiffyBottomSheet.lottie(
            LottieBuilder(
                lottie: AssetLottie(
              'assets/lottie/animation_lmsuu999.json',
            )),
            title: const Text("No Internet Connection"),
            content: const Text(
              "Please check your internet connection and try again.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            giffyPadding: const EdgeInsets.symmetric(horizontal: 60),
          );
        });
  }

  static void errorDialog(BuildContext context, {String? message}) {
    showDialog(
        context: context,
        builder: (_) {
          return GiffyDialog.lottie(
            LottieBuilder(lottie: AssetLottie(Assets.lottieIssue)),
            title: const Text("Opps!"),
            content: Text(
              message ?? "Something went wrong. Please try again later.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          );
        });
  }

  static void successDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return GiffyDialog.lottie(
            LottieBuilder(
                lottie: AssetLottie(
              Assets.lottieSuccess,
            )),
            title: const Text("Success"),
            content: const Text(
              "Your attendance has been successfully submitted.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          );
        });
  }
}
