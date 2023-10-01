import 'package:employee_attendance_system/features/attendance/controller/attandance_controller.dart';
import 'package:employee_attendance_system/features/auth/controller/auth_controller.dart';
import 'package:employee_attendance_system/features/auth/data/repository/auth_repository.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/attendance_repository.dart';

final getIt = GetIt.instance;

setUp() {
  getIt.registerLazySingleton<AttendanceController>(
      () => AttendanceController());

//  getIt.registerLazySingleton(() => AttendanceRepositoryImpl());

  getIt.registerLazySingleton<AttendanceRepository>(
      () => AttendanceRepositoryImpl());

  getIt.registerLazySingleton<AuthController>(() => AuthController());

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
}
