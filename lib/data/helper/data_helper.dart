import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AppDataHelper {
  static Map<String, String> header = {
    "skey": "5f3e42e30e01a9b3624f2e8d81ebc94c"
  };

  static Future<XFile?> compressFile(File photoFile) async {
    var _data = await FlutterImageCompress.compressAndGetFile(
      photoFile.absolute.path,
      photoFile.absolute.path,
      quality: 50,
    );

    print("Compress File: $_data");

    return _data;
  }
}
