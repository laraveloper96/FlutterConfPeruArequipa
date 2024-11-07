import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static Future<String?> getFilePath() async {
    Directory? dir;
    final filename =
        '/arm-robotic-moves-${DateFormat('yyyyMMddHms').format(DateTime.now())}.json';
    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      } else {
        dir = Directory('/storage/emulated/0/Download');
        final exist = dir.existsSync();
        if (!exist) dir = await getExternalStorageDirectory();
      }
    } catch (err) {
      debugPrint('Cannot get download folder path $err');
      return null;
    }
    return '${dir?.path}$filename';
  }

  static Future<String?> openFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // allowedExtensions: ['json'],
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      return file.path;
    } else {}
    return null;
  }
}
