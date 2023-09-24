import 'package:employee_attendance_system/core/utls/dimension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF00988F);
  static const Color primaryColorDark = Color(0xFF74DABE);
  static const Color primaryColorLight = Color(0xFFBB86FC);
  static const Color secondaryColor = Color(0xFF03DAC5);
  static const Color secondaryColorDark = Color(0xFF018786);

  static const Color backgroundColor = Color(0xFFF5FFF6);

  // Text
  static const String fontFamily = 'Roboto';

  // Text Styles for body text

  static const TextStyle bodyText1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppDimension.textSizeMedium,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
    color: Colors.black,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppDimension.textSizeMedium,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
    color: Colors.black,
  );

  // large text styles

  static const TextStyle headline1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppDimension.textSizeXXXLarge,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    height: 1.5,
    color: Colors.black,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppDimension.textSizeXXLarge,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    height: 1.5,
    color: Colors.black,
  );

  static const TextStyle headline3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppDimension.textSizeXLarge,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.5,
    color: Colors.black,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppDimension.textSizeLarge,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
    color: Colors.black,
  );

  //get theme

  static ThemeData getTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: primaryColor,
        elevation: 5,

      ),
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      secondaryHeaderColor: secondaryColor,
      textTheme: const TextTheme(
        bodyMedium: bodyText1,
        bodySmall: bodyText2,
        displayLarge: headline1,
        displayMedium: headline2,
        displaySmall: headline3,
        titleLarge: headline4,
        titleMedium: headline4,
        titleSmall: headline4,
        labelLarge: headline4,
        labelMedium: headline4,
        labelSmall: headline4,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: headline4,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: headline4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.borderRadius),
          ),
        ),
      ),
    );
  }
}
