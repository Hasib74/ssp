import 'package:employee_attendance_system/core/utls/app_spaces.dart';
import 'package:employee_attendance_system/core/widgets/app_drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/DI/depandancy_injection.dart';
import '../../../../../core/widgets/app_text_filed.dart';
import '../../controller/attandance_controller.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                var _data = await showDatePicker(
                    context: context,
                    initialDate:
                        DateTime.now().subtract(const Duration(days: 365 * 5)),
                    lastDate: DateTime.now(),
                    firstDate: DateTime(1900));

                if (_data != null) {
                  getIt<AttendanceController>().dateOfBirthController.text =
                      DateFormat('dd/MM/yyyy').format(_data);

                  print(DateFormat('dd/MM/yyyy').format(_data));

                  setState(() {});
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: AppTextFiled(
                  context: context,
                  controller:
                      getIt<AttendanceController>().dateOfBirthController,
                  enabled: false,
                  isRequired: false,
                  label: "Date Of Birth",
                  hint: 'mm/dd/yyyy',
                  suffixIcon: Icons.calendar_today,
                ),
              ),
            ),
            AppSpaces.spaceHeight20,
            AppDropDownMenu(
                stateKey: getIt<AttendanceController>().bloodGroupDropDownKey,
                controller: getIt<AttendanceController>().bloodGroupController,
                label: "Blood Group",
                menus: const [
                  "A+",
                  "B+",
                  "O+",
                  "AB+",
                  "A-",
                  "B-",
                  "O-",
                  "AB-"
                ]),
          ],
        ),
      ),
    );
  }
}
