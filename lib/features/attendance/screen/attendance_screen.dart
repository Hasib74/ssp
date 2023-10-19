import 'dart:io';

import 'package:employee_attendance_system/features/attendance/screen/section/basic_info.dart';
import 'package:employee_attendance_system/features/attendance/screen/section/id_card_info.dart';
import 'package:employee_attendance_system/features/attendance/screen/section/office_info.dart';
import 'package:employee_attendance_system/package/fromBuilderImagePicker/lib/form_builder_image_picker.dart';
import 'package:employee_attendance_system/package/fromBuilderImagePicker/lib/src/controller/image_picker_controller.dart';
import 'package:flutter/material.dart';

import '../../../core/DI/depandancy_injection.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utls/app_spaces.dart';
import '../controller/attandance_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime? currentBackPressTime;

  bool? isLoading = false;

  // FromBuilderController photoFromBuilderController = FromBuilderController();

  // FromBuilderController signatureFromBuilderController = FromBuilderController();
  ImagePickerController photoImagePickerController = ImagePickerController();

  ImagePickerController signatureImagePickerController =
      ImagePickerController();

  Future<bool> _onBackPressed() {
    DateTime now = DateTime.now();

    // Allow exit if the back button is pressed twice within 2 seconds
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Press back again to exit",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getIt<AttendanceController>().getBloodGroup(context, setState);
    getIt<AttendanceController>().getSSPList(context, setState);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    photoImagePickerController.dispose();
    signatureImagePickerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading!,
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Are you sure to exit?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "No",
                          style: TextStyle(color: Colors.green),
                        )),
                    TextButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.red),
                        )),
                  ],
                );
              });

          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            title: const Text("SSP Attendance"),
            centerTitle: true,
          ),
          backgroundColor: AppTheme.backgroundColor,
          body: SafeArea(
            child: ListView(
              children: [
                Form(
                    key: getIt<AttendanceController>().fromKey,
                    child: Column(
                      children: [
                        IdCardInfo(
                          imagePickerController: photoImagePickerController,
                          //   fromBuilderController: photoFromBuilderController,
                        ),
                        OfficeInfo(
                          imagePickerController: signatureImagePickerController,
                          /* fromBuilderController:
                              signatureFromBuilderController!,*/
                        ),
                        const UserInfo(),
                      ],
                    )),
                AppSpaces.spaceHeight20,
                AppSpaces.spaceHeight20,
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //height
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () async {
                        await getIt<AttendanceController>()
                            .postAttendance(context, () {
                          setState(() {
                            isLoading = false;
                          });

                          photoImagePickerController.removeImage();
                          signatureImagePickerController.removeImage();
                        }, (bool? isValidated) {
                          if (isValidated != null && isValidated) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                        });

                        //  FormBuilderImagePickerState().value?.clear();

                        setState(() {});
                      },
                      child: const Center(child: Text("Submit"))),
                ),
                AppSpaces.spaceHeight20,
                AppSpaces.spaceHeight20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
