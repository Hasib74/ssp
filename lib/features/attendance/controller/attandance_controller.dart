import 'dart:io';

import 'package:employee_attendance_system/core/DI/depandancy_injection.dart';
import 'package:employee_attendance_system/core/theme/app_theme.dart';
import 'package:employee_attendance_system/core/utls/app_spaces.dart';
import 'package:employee_attendance_system/data/model/blood_group_model.dart';
import 'package:employee_attendance_system/data/model/ssp_list_model.dart';
import 'package:employee_attendance_system/data/repository/attendance_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';

class AttendanceController {
  var fromKey = GlobalKey<FormState>();
  File? photoFile;
  File? signatureFile;

  BloodGroupModel? bloodGroupModel = BloodGroupModel();
  SspListModel? sspListModel = SspListModel();

  final GlobalKey<FormFieldState> officeCategoryDropDownKey =
      GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> postingPlaceSSPNameDropDownKey =
      GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> bloodGroupDropDownKey =
      GlobalKey<FormFieldState>();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController designationController = TextEditingController();

  TextEditingController nidIsNidJbraNoController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  // TextEditingController officeCategoryController = TextEditingController();

  //TextEditingController officeNameController = TextEditingController();

  TextEditingController postingPlaceSSPNameController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController bloodGroupController = TextEditingController();

  var photoKey = GlobalKey<FormFieldState>();

//  TextEditingController genderTextEditingController = TextEditingController();

  getBloodGroup(
      BuildContext context, void Function(VoidCallback fn) setState) async {
    BloodGroupModel? _bloodGroupModel =
        await getIt<AttendanceRepository>().getBloodGroup(context);

    if (_bloodGroupModel != null) {
      bloodGroupModel = _bloodGroupModel;

      setState(() {});
    }
  }

  getSSPList(
      BuildContext context, void Function(VoidCallback fn) setState) async {
    SspListModel? _sspListModel =
        await getIt<AttendanceRepository>().getSSPList(context);

    if (_sspListModel != null) {
      sspListModel = _sspListModel;

      setState(() {});
    }
  }

  Future postAttendance(BuildContext context, Callback? onDone,
      Function(bool?) isValidated) async {
    if (_validated()) {
      bool? _confirmDialog =
          await showDialog(context: context, builder: _confirmDialogBuilder);

      if (_confirmDialog == false) {
        return;
      }

      var _date = dateOfBirthController.text.isNotEmpty
          ? convertDateFormat(dateOfBirthController.text)
          : "";

      print("The date : $_date");

      Map<String, String> body = {
        "full_name": fullNameController.value.text,
        "designation": designationController.value.text,
        "nid_snid_brc": nidIsNidJbraNoController.value.text,
        "phone_no": phoneNumberController.value.text,
        "email": emailController.value.text,
        //  "office_category": officeCategoryController.value.text,
        //  "office_name": officeNameController.value.text,
        "posting_place_ssp_name": sspListModel?.data == null
            ? ""
            : sspListModel!.data!
                .where((element) =>
                    element.name == postingPlaceSSPNameController.value.text)
                .last
                .id
                .toString(),
        "date_of_birth": dateOfBirthController.text.isNotEmpty ? _date : "",
        "blood_group": bloodGroupModel?.data == null
            ? ""
            : bloodGroupModel!.data!
                .where((element) =>
                    element.name == bloodGroupController.value.text)
                .last
                .id
                .toString(),
        "status": "1"
      };

      isValidated(true);

      bool? isSuccess = await getIt<AttendanceRepository>()
          .postAttendance(context, body, photoFile, signatureFile);

      if (isSuccess == true) {
        fullNameController.clear();
        designationController.clear();
        nidIsNidJbraNoController.clear();
        phoneNumberController.clear();
        emailController.clear();
        //officeCategoryController.clear();
        // officeNameController.clear();
        postingPlaceSSPNameController.clear();
        dateOfBirthController.clear();
        bloodGroupController.clear();
        //    photoFile = null;
        // signatureFile = null;
        officeCategoryDropDownKey.currentState?.reset();
        postingPlaceSSPNameDropDownKey.currentState?.reset();
        bloodGroupDropDownKey.currentState?.reset();

        if (onDone != null) {
          onDone();
        }
      }
    }
  }

  bool _validated() {
    if (fromKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  String convertDateFormat(String inputDate) {
    // Define the input and output date formats
    final inputFormat = DateFormat('dd/MM/yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');

    // Parse the input date
    final date = inputFormat.parse(inputDate);

    // Format the date in the desired output format
    final formattedDate = outputFormat.format(date);

    return formattedDate;
  }

  Widget _confirmDialogBuilder(BuildContext context) {
    return Dialog(
      child: Container(
        //height: double.min,
        // height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Are you sure to submit?",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w800)),
            ),
            Expanded(
              child: _information(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  _information(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (photoFile != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Photo",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(

                          //
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    AppSpaces.spaceHeight10,
                    Image.file(photoFile!, height: 100, width: 100),
                  ],
                ),
              ),
            AppSpaces.spaceHeight15,
            if (signatureFile != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Signature",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppTheme.primaryColor, fontWeight: FontWeight.w500),
                    ),
                    AppSpaces.spaceHeight10,
                    Image.file(signatureFile!, height: 100, width: 100),
                  ],
                ),
              ),
            //  AppSpaces.spaceHeight15,
            _itemAndValue(context, "Full Name", fullNameController.value.text),
            //   AppSpaces.spaceHeight15,
            _itemAndValue(
                context, "Designation", designationController.value.text),
            // AppSpaces.spaceHeight15,
            _itemAndValue(
                context, "NID/SNID/BRC", nidIsNidJbraNoController.value.text),
            // AppSpaces.spaceHeight15,
            _itemAndValue(
                context, "Phone Number", phoneNumberController.value.text),
            // AppSpaces.spaceHeight15,
            _itemAndValue(context, "Email", emailController.value.text),
            // AppSpaces.spaceHeight15,
            _itemAndValue(context, "Posting Place",
                postingPlaceSSPNameController.value.text),
            //  AppSpaces.spaceHeight15,
            _itemAndValue(
                context, "Date Of Birth", dateOfBirthController.value.text),
            // AppSpaces.spaceHeight15,
            _itemAndValue(
                context, "Blood Group", bloodGroupController.value.text),
          ]),
    );
  }

  _itemAndValue(BuildContext context, String s, String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(s,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppTheme.primaryColor, fontWeight: FontWeight.w500)),
            flex: 1,
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),

            ),
            flex: 2,
          )
        ],
      ),
    );
  }
}
