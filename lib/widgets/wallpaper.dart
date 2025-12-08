import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/services/wallpaper_service.dart';

class Wallpaper extends StatefulWidget {
  final Widget child;

  const Wallpaper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  @override
  void initState() {
    super.initState();
    WallpaperService.instance.loadSelectedWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: WallpaperService.instance.wallpaperNotifier,
      builder: (context, wallpaperId, child) {
        return Stack(
          children: [
            _buildWallpaper(wallpaperId),
            widget.child,
          ],
        );
      },
    );
  }

  Widget _buildWallpaper(String wallpaperId) {
    if (wallpaperId.startsWith('/')) {
      // Custom wallpaper
      final file = File(wallpaperId);
      if (file.existsSync()) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(file),
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    }

    // Preset wallpaper
    final gradient = WallpaperService.presetWallpapers[wallpaperId];
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
    );
  }
}
