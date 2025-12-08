import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WallpaperService {
  static final instance = WallpaperService._();
  WallpaperService._();

  static const String _selectedWallpaperKey = 'selected_wallpaper';

  final ValueNotifier<String> wallpaperNotifier = ValueNotifier<String>('calm_ocean');

  static final Map<String, Gradient> presetWallpapers = {
    'calm_ocean': const LinearGradient(
      colors: [Color(0xFF6DD5FA), Color(0xFF2980B9)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    'sunrise': const LinearGradient(
      colors: [Color(0xFFFFC3A0), Color(0xFFFF7E5F)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    'graph_paper': const LinearGradient(
      colors: [Color(0xFFF1F1F1), Color(0xFFE0E0E0)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    'night_mode': const LinearGradient(
      colors: [Color(0xFF2C3E50), Color(0xFF000000)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  };

  Future<void> loadSelectedWallpaper() async {
    final prefs = await SharedPreferences.getInstance();
    wallpaperNotifier.value = prefs.getString(_selectedWallpaperKey) ?? 'calm_ocean';
  }

  Future<void> setSelectedWallpaper(String wallpaperId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedWallpaperKey, wallpaperId);
    wallpaperNotifier.value = wallpaperId;
  }

  Future<String> processAndSaveCustomWallpaper(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception('Could not decode image');
    }

    // Blur and desaturate the image
    img.gaussianBlur(image, 10);
    img.grayscale(image);

    // Dim the image by drawing a semi-transparent black rectangle over it
    img.fillRect(image, 0, 0, image.width, image.height, 0x80000000);

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/custom_wallpaper.png';
    final processedImageFile = File(path);
    await processedImageFile.writeAsBytes(img.encodePng(image));

    return path;
  }
}
