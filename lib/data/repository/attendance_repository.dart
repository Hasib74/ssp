import 'dart:convert';
import 'dart:io';

import 'package:employee_attendance_system/core/network/check_internet.dart';
import 'package:employee_attendance_system/core/widgets/app_dialog.dart';
import 'package:employee_attendance_system/data/helper/data_helper.dart';
import 'package:employee_attendance_system/data/urls/app_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../model/blood_group_model.dart';
import '../model/ssp_list_model.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class AttendanceRepository {
  Future<BloodGroupModel?> getBloodGroup(BuildContext context);

  Future<SspListModel?> getSSPList(BuildContext context);

  Future<bool?> postAttendance(BuildContext context, Map<String, String> body,
      File? photoFile, File? signatureFile);
}

class AttendanceRepositoryImpl extends AttendanceRepository {
  @override
  Future<BloodGroupModel?> getBloodGroup(BuildContext context) async {
// check internet if internet not connected then make a Toast message and if internet is available then call api.

    print("Request: ${AppUrl.getBloodGroup}");
    try {
      if (await AppCheckInternet.check() == true) {
        EasyLoading.show();

        var response = await get(Uri.parse(AppUrl.getBloodGroup),
            headers: AppDataHelper.header);

        EasyLoading.dismiss();

        if (response.statusCode == 200) {
          return BloodGroupModel.fromJson(jsonDecode(response.body));
        } else {
          AppDialog.errorDialog(context);
        }
      } else {
        AppDialog.noInternetDialog(context: context);
      }
    } on Exception catch (e) {
      // TODO

      AppDialog.errorDialog(context, message: e.toString());

      EasyLoading.dismiss();
    }
  }

  @override
  Future<SspListModel?> getSSPList(BuildContext context) async {
    print("Request: ${AppUrl.getSSpList}");

    try {
      if (await AppCheckInternet.check() == true) {
        EasyLoading.show();

        var response = await get(Uri.parse(AppUrl.getSSpList),
            headers: AppDataHelper.header);

        EasyLoading.dismiss();
        if (response.statusCode == 200) {
          return SspListModel.fromJson(jsonDecode(response.body));
        } else {
          AppDialog.errorDialog(context);
        }
      } else {
        AppDialog.noInternetDialog(context: context);
      }
    } on Exception catch (e) {
      AppDialog.errorDialog(context, message: e.toString());

      EasyLoading.dismiss();
      // TODO
    }
  }

  @override
  Future<bool?> postAttendance(BuildContext context, Map<String, String> body,
      File? photoFile, File? signatureFile) async {
    print("Requested body: $body");
    var request = MultipartRequest('POST', Uri.parse(AppUrl.idCardStore));

    if (signatureFile != null) {
      //  var _compressedFile = await AppDataHelper.compressFile(signatureFile);

      // print("Compressed File Signature : $_compressedFile");

      var signatureFileReq = await MultipartFile.fromPath(
          'signature_upload', signatureFile.path.toString() ?? "");

      request.files.add(signatureFileReq);
    }

    if (photoFile != null) {
      //   var _compressedFile = await AppDataHelper.compressFile(photoFile);

      //print("Compressed File Photo : $_compressedFile");

      var photoFileReq = await MultipartFile.fromPath(
          'photo', photoFile.path.toString() ?? "");

      request.files.add(photoFileReq);
    }

    request.fields.addAll(body);

    request.headers.addAll(AppDataHelper.header);

    if (await AppCheckInternet.check() == true) {
      try {
        EasyLoading.show();

        var response = await request.send();

        EasyLoading.dismiss();

        if (response.statusCode == 200) {
          AppDialog.successDialog(context);
          return true;
        } else {
          var message = await response.stream.bytesToString();

          print("Response: ${jsonDecode(message)["message"]}");
          AppDialog.errorDialog(context,
              message: jsonDecode(message)["message"]);
        }
      } on Exception catch (e) {
        // TODO
        EasyLoading.dismiss();
        AppDialog.errorDialog(context, message: e.toString());
      }
    } else {
      AppDialog.noInternetDialog(context: context);
    }
  }
}
