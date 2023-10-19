import 'dart:io';

import 'package:employee_attendance_system/core/utls/app_spaces.dart';
import 'package:employee_attendance_system/core/utls/dimension.dart';
import 'package:employee_attendance_system/core/widgets/app_text_filed.dart';
import 'package:employee_attendance_system/features/attendance/controller/attandance_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../core/DI/depandancy_injection.dart';
import '../../../../package/fromBuilderImagePicker/lib/form_builder_image_picker.dart';
import '../../../../package/fromBuilderImagePicker/lib/src/controller/image_picker_controller.dart';

class IdCardInfo extends StatelessWidget {
  ImagePickerController imagePickerController;

  IdCardInfo({super.key, required this.imagePickerController});

  VoidCallback? removeImageForImageFiled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimension.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("ID Card Info", style: Theme.of(context).textTheme.titleMedium),
          AppSpaces.spaceHeight20,
          AppTextFiled(
            context: context,
            controller: getIt<AttendanceController>().fullNameController,
            isRequired: true,
            label: "Full Name",
            hint: 'Enter Name',
            textInputType: TextInputType.name,
          ),
          AppSpaces.spaceHeight20,
          AppTextFiled(
            context: context,
            controller: getIt<AttendanceController>().designationController,
            isRequired: true,
            label: "Designation",
            hint: 'Enter Designation',
            textInputType: TextInputType.name,
          ),
          AppSpaces.spaceHeight10,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FormBuilderImagePicker(
                imagePickerController: imagePickerController,
                // fromBuilderController: fromBuilderController,
                key: getIt<AttendanceController>().photoKey,
                backgroundColor: Colors.transparent,
                name: 'photo',
                decoration: const InputDecoration(labelText: 'Pick Photo'),
                maxImages: 1,
                previewHeight: 45,
                onImage: (XFile image) {
                  getIt<AttendanceController>().photoFile = File(image.path);
                },
                onRemove: () {
                  getIt<AttendanceController>().photoFile = null;
                },
              ),
            ],
          ),
          AppSpaces.spaceHeight20,
          AppTextFiled(
            context: context,
            controller: getIt<AttendanceController>().nidIsNidJbraNoController,
            isRequired: true,
            label: "NID/BRC Number",
            hint: 'NID/BRC Number',
            textInputType: TextInputType.name,
          ),
          AppSpaces.spaceHeight15,
          AppTextFiled(
            context: context,
            controller: getIt<AttendanceController>().phoneNumberController,
            isRequired: false,
            label: "Phone Number",
            hint: 'Enter Phone Number',
            textInputType: TextInputType.number,
          ),
          AppSpaces.spaceHeight15,
          AppTextFiled(
            isEmail: true,
            context: context,
            controller: getIt<AttendanceController>().emailController,
            isRequired: false,
            label: "Email",
            hint: 'Enter Email',
            textInputType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
