import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status_save_whatsapp/constants/constants.dart';

class GetStatusesProvider extends ChangeNotifier {
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];

  bool _isWhatsappAvailable = false;

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;

  bool get isWhatsappAvailable => _isWhatsappAvailable;

  Future<void> getStatuses(String ext) async {
    final status = await Permission.storage.request();

    Directory? directory = await getExternalStorageDirectory();

    if (status.isDenied) {
      Permission.storage.request();
      print('Permissão negada');
      return;
    }

    if (status.isGranted) {
      final directory = Directory(Constants.whatsapp_path);

      if (directory.existsSync()) {
        final items = directory.listSync();

        if (ext == '.mp4') {
          _getVideos =
              items.where((element) => element.path.endsWith('.mp4')).toList();
          notifyListeners();
        } else {
          _getImages =
              items.where((element) => element.path.endsWith('.jpg')).toList();
          notifyListeners();
        }

        _isWhatsappAvailable = true;
        notifyListeners();
      } else {
        print('No Whatsapp found');
      }
    }
  }
}
