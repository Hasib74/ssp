import 'package:employee_attendance_system/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppTextFiled extends StatelessWidget {
  String? label;
  String? hint;
  String? errorText;
  bool? isObscure;
  TextEditingController? controller;
  TextInputType? textInputType;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;
  Function? onChanged;
  Function? onEditingComplete;
  Function? onTap;
  Function? onSaved;
  Function? validator;
  int? maxLength;
  int? maxLines;
  int? minLines;
  bool? enabled;
  bool? readOnly;
  bool? autoFocus;
  bool? autoValidate;
  bool? enableInteractiveSelection;
  bool? filled;
  bool? isDense;
  bool? isCollapsed;
  bool? isExpanded;
  bool? showCursor;
  bool? autofocus;
  bool? enableSuggestions;
  bool? autocorrect;
  bool? enableSuggestionsForced;
  bool? showSelectionHandles;
  bool? obscuringCharacter;
  bool? obscureText;
  bool? autocorrectText;
  bool? enableIMEPersonalizedLearning;
  bool? enableIMEPrediction;
  bool? enableIMEAutoInitialization;
  bool? enableIMEAutoComplete;
  bool? enableIMEAutoCorrect;
  bool? enableIMEAutoCapitalize;
  bool? isRequired;
  IconData? suffixIcon;
  IconData? prefixIcon;

  BuildContext context;

  bool? isEmail;

  Function(String?)? onValidation;

  List<String>? dropDownMenu = [];

  AppTextFiled(
      {super.key,
      this.label,
      this.hint,
      this.errorText,
      this.isObscure,
      this.controller,
      this.textInputType,
      this.textInputAction,
      this.focusNode,
      this.onFieldSubmitted,
      this.onChanged,
      this.onEditingComplete,
      this.onTap,
      this.onSaved,
      this.validator,
      this.maxLength,
      this.maxLines,
      this.minLines,
      this.enabled,
      this.readOnly,
      this.autoFocus,
      this.autoValidate,
      this.enableInteractiveSelection,
      this.filled,
      this.isDense,
      this.isCollapsed,
      this.isExpanded,
      this.showCursor,
      this.autofocus,
      this.enableSuggestions,
      this.autocorrect,
      this.enableSuggestionsForced,
      this.showSelectionHandles,
      this.obscuringCharacter,
      this.obscureText,
      this.autocorrectText,
      this.enableIMEPersonalizedLearning,
      this.enableIMEPrediction,
      this.enableIMEAutoInitialization,
      this.enableIMEAutoComplete,
      this.enableIMEAutoCorrect,
      this.enableIMEAutoCapitalize,
      this.isRequired,
      this.suffixIcon,
      this.prefixIcon,
      this.dropDownMenu,
      this.onValidation,
      this.isEmail,
      required this.context});

  @override
  Widget build(BuildContext context) {
    return dropDownMenu != null ? _textFiled() : _textFiled();
  }

  TextFormField _textFiled() {
    return TextFormField(
      // focusNode: focusNode ?? FocusNode(),
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        contentPadding: const EdgeInsets.all(10),
        //   isDense: isDense ?? false,
        //isCollapsed: isCollapsed ?? false,
        //   filled: filled ?? false,
        //   labelText: label,
        label: Wrap(
          children: [
            Text(label!),
            if (isRequired ?? false)
              const Text(
                "*",
                style: TextStyle(color: Colors.red),
              )
          ],
        ),
        hintText: hint,
        errorText: errorText,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppTheme.primaryColor,
            width: 1,
          ),

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppTheme.primaryColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppTheme.primaryColor,
            width: 1,
          ),
        ),
      ),
      obscureText: isObscure ?? false,
      controller: controller,
      keyboardType: textInputType,
      textInputAction: TextInputAction.next,
      onChanged: onChanged as void Function(String)?,
      onEditingComplete: onEditingComplete as void Function()?,
      onTap: onTap as void Function()?,
      maxLength: maxLength,
      maxLines: 1,
      minLines: minLines ?? 1,
      enabled: enabled,
      readOnly: readOnly ?? false,
      autofocus: autofocus ?? false,
      enableInteractiveSelection: enableInteractiveSelection,
      showCursor: showCursor,
      autocorrect: autocorrect ?? false,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning ?? false,
      validator: (value) {
        if (isRequired ?? false) {
          if (value!.isEmpty) {
            return "This field is required";
          }

          if (isEmail == true && !value.contains("@")) {
            return "Please enter valid email";
          }
        }
        if (onValidation != null) {
          return onValidation!(value);
        }
        return null;
      },
    );
  }
}
