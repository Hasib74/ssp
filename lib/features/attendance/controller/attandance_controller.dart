import 'dart:io';

import 'package:employee_attendance_system/core/DI/depandancy_injection.dart';
import 'package:employee_attendance_system/data/model/blood_group_model.dart';
import 'package:employee_attendance_system/data/model/ssp_list_model.dart';
import 'package:employee_attendance_system/data/repository/attendance_repository.dart';
import 'package:flutter/cupertino.dart';
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

  TextEditingController officeCategoryController = TextEditingController();

  TextEditingController officeNameController = TextEditingController();

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

  postAttendance(BuildContext context, Callback? onDone) async {
    if (_validated()) {
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
        "office_category": officeCategoryController.value.text,
        "office_name": officeNameController.value.text,
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

      bool? isSuccess = await getIt<AttendanceRepository>()
          .postAttendance(context, body, photoFile, signatureFile);

      if (isSuccess == true) {
        fullNameController.clear();
        designationController.clear();
        nidIsNidJbraNoController.clear();
        phoneNumberController.clear();
        emailController.clear();
        officeCategoryController.clear();
        officeNameController.clear();
        postingPlaceSSPNameController.clear();
        dateOfBirthController.clear();
        bloodGroupController.clear();
        photoFile = null;
        signatureFile = null;
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
}
