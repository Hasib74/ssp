import 'package:employee_attendance_system/features/attendance/screen/section/basic_info.dart';
import 'package:employee_attendance_system/features/attendance/screen/section/id_card_info.dart';
import 'package:employee_attendance_system/features/attendance/screen/section/office_info.dart';
import 'package:flutter/material.dart';

import '../../../core/DI/depandancy_injection.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utls/app_spaces.dart';
import '../controller/attandance_controller.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getIt<AttendanceController>().getBloodGroup(context, setState);
    getIt<AttendanceController>().getSSPList(context, setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                    const IdCardInfo(),
                    OfficeInfo(),
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
                  ),
                  onPressed: () {
                    getIt<AttendanceController>().postAttendance(context, () {
                      setState(() {});
                    });
                  },
                  child: const Center(child: Text("Submit"))),
            ),
            AppSpaces.spaceHeight20,
            AppSpaces.spaceHeight20,
          ],
        ),
      ),
    );
  }
}
