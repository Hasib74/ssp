import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:employee_attendance_system/core/widgets/AppFilePicker/app_file_picker.dart';
import 'package:employee_attendance_system/core/widgets/app_text_filed.dart';
import 'package:employee_attendance_system/features/attendance/controller/attandance_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../core/DI/depandancy_injection.dart';
import '../../../../../core/utls/app_spaces.dart';
import '../../../../../core/widgets/app_drop_down_menu.dart';
import '../../../../package/fromBuilderImagePicker/lib/form_builder_image_picker.dart';

class OfficeInfo extends StatelessWidget {
  String? label;
  List<String>? menus = [];

  OfficeInfo({super.key, this.label, this.menus});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppDropDownMenu(
          stateKey: getIt<AttendanceController>().officeCategoryDropDownKey,
          label: "Office Category",
          menus: ["Head Office", "Branch Office"],
          controller: getIt<AttendanceController>().officeCategoryController,
        ),
        AppSpaces.spaceHeight20,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: AppTextFiled(
            context: context,
            controller: getIt<AttendanceController>().officeNameController,
            isRequired: true,
            label: "Office Name",
            hint: 'Enter Office Name',
            textInputType: TextInputType.name,
          ),
        ),
        AppSpaces.spaceHeight20,
        AppDropDownMenu(
            stateKey:
                getIt<AttendanceController>().postingPlaceSSPNameDropDownKey,
            controller:
                getIt<AttendanceController>().postingPlaceSSPNameController,
            label: "Posing Place/SSP Name *",
            menus: getIt<AttendanceController>().sspListModel?.data == null
                ? []
                : getIt<AttendanceController>()
                        .sspListModel
                        ?.data!
                        .map((e) => e.name!)
                        .toList() ??
                    []),
        AppSpaces.spaceHeight20,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: FormBuilderImagePicker(
            backgroundColor: Colors.transparent,
            name: 'Signature Upload',
            decoration: const InputDecoration(labelText: 'Signature Upload'),
            maxImages: 1,
            previewHeight: 45,
            onImage: (XFile image) {
              getIt<AttendanceController>().signatureFile = File(image.path);
            },
            onRemove: () {
              getIt<AttendanceController>().signatureFile = null;
            },
          ),
        ),
        AppSpaces.spaceHeight20,
      ],
    );
  }
}
