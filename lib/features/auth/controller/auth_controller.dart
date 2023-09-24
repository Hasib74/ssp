import 'package:employee_attendance_system/core/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../attendance/screen/attendance_screen.dart';

class AuthController {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var fromKey = GlobalKey<FormState>();

  signIn(BuildContext context) {

    if (_validated()) {
      EasyLoading.show();
      if (userIdController.value.text == "dssssp" &&
          passwordController.value.text == "dssssp1234") {
        EasyLoading.dismiss();
        Navigator.of(context).push(
            new MaterialPageRoute(builder: (context) => AttendanceScreen()));
      } else {
        EasyLoading.dismiss();

        AppDialog.errorDialog(context, message: "Invalid User Id or Password");
      }
    }

    // if (formKey.currentState?.validate()) {
    //   if (userIdController.value.text == "dssssp" &&
    //       passwordController == "dssssp1234") {
    //     Navigator.of(context).push(
    //         new MaterialPageRoute(builder: (context) => AttendanceScreen()));
    //   }
    // }

    //   Navigator.of(context).push(new MaterialPageRoute(builder: (context) => AttendanceScreen()));
  }

  bool _validated() {
    if (fromKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
