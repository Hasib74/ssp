import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog {
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      // You can handle the picked image here, e.g., display it or save it.
      // For example, you can use Image.file to display the selected image:
      // Image.file(File(pickedFile.path));

      Navigator.of(context).pop(File(pickedFile.path));
    } else {
      // User canceled the image selection.
    }

    // Close the dialog.
  }

  showDialog(
    BuildContext context,
  ) {
    return AlertDialog(
      title: Text('Select Image Source'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Gallery'),
            onTap: () {
              _pickImage(context, ImageSource.gallery);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text('Camera'),
            onTap: () {
              _pickImage(context, ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }
}
