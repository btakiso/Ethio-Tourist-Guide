// File: lib/utils/download_util.dart
import 'package:flutter_archive/flutter_archive.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import './network_check.dart'; // Import NetworkCheck for connectivity checks

class DownloadUtil {
  static Future<void> downloadContentPack(String url, String zipFileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final zipFilePath = path.join(directory.path, zipFileName);
      final zipFile = await _downloadFile(url, zipFilePath);

      // Unzip the content pack
      final destinationDir = directory.path;
      await ZipFile.extractToDirectory(zipFile: File(zipFile), destinationDir: directory);
      print('Extraction completed to $destinationDir');
    } catch (e) {
      print('Error downloading or extracting content pack: $e');
    }
  }

  static Future<String> _downloadFile(String url, String filePath) async {
    try {
      final response = await http.get(Uri.parse(url));
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } catch (e) {
      print('Error downloading file: $e');
      throw Exception('Error downloading file: $e');
    }
  }

  static Future<void> checkForUpdatesAndDownloadContentPack(String contentPackUrl, String zipFileName) async {
    try {
      final isConnected = await NetworkCheck.isConnected();
      if (isConnected) {
        print('Internet connection detected. Checking for content pack updates.');
        await downloadContentPack(contentPackUrl, zipFileName);
      } else {
        print('No internet connection detected. Skipping content pack update.');
      }
    } catch (e) {
      print('Error checking for updates or downloading content pack: $e');
    }
  }
}