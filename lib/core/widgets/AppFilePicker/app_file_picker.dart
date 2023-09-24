import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

import '_app_image_picker.dart';

part '_file_picker_ui.dart';

enum FileType {
  image,
  video,
  file,
}

typedef onFile = void Function(File file);

@immutable
class AppFilePicker extends StatelessWidget {
  FileType? fileType;
  String? label;

  AppFilePicker({super.key, this.fileType, this.label});

  @override
  Widget build(BuildContext context) {
    switch (fileType) {
      case FileType.image:
        return _FilePickerUI(
          label: label,
          fileType: fileType,
        );

      case FileType.video:
        return _FilePickerUI(
          label: label,
          fileType: fileType,
        );

      case FileType.file:
        return _FilePickerUI(
          label: label,
          fileType: fileType,
        );

      case null:
        return Container();
    }
  }
}
