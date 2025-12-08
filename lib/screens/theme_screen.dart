import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tic_tac_toe/services/wallpaper_service.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  String _selectedWallpaperId = 'calm_ocean';
  File? _customWallpaperFile;

  @override
  void initState() {
    super.initState();
    _selectedWallpaperId = WallpaperService.instance.wallpaperNotifier.value;
  }

  Future<void> _selectCustomWallpaper() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _customWallpaperFile = file;
        _selectedWallpaperId = 'custom';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme & Wallpaper'),
      ),
      body: Column(
        children: [
          _buildPreview(),
          Expanded(
            child: _buildWallpaperOptions(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_selectedWallpaperId == 'custom' && _customWallpaperFile != null) {
            final path = await WallpaperService.instance
                .processAndSaveCustomWallpaper(_customWallpaperFile!);
            await WallpaperService.instance.setSelectedWallpaper(path);
          } else {
            await WallpaperService.instance
                .setSelectedWallpaper(_selectedWallpaperId);
          }
          Navigator.pop(context);
        },
        child: const Icon(Icons.check),
        tooltip: 'Apply',
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2.0,
        ),
        gradient: _selectedWallpaperId != 'custom'
            ? WallpaperService.presetWallpapers[_selectedWallpaperId]
            : null,
        image: _selectedWallpaperId == 'custom' && _customWallpaperFile != null
            ? DecorationImage(
                image: FileImage(_customWallpaperFile!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Center(
            child: Text(
              'X O',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWallpaperOptions() {
    return ListView(
      children: [
        ListTile(
          title: const Text('Preset Wallpapers'),
          dense: true,
          titleAlignment: ListTileTitleAlignment.center,
        ),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: WallpaperService.presetWallpapers.entries.map((entry) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedWallpaperId = entry.key;
                    _customWallpaperFile = null;
                  });
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: entry.value,
                    border: _selectedWallpaperId == entry.key
                        ? Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 3.0,
                          )
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        ListTile(
          title: const Text('Custom'),
          dense: true,
          titleAlignment: ListTileTitleAlignment.center,
        ),
        ListTile(
          leading: const Icon(Icons.photo),
          title: const Text('Use my photo'),
          onTap: _selectCustomWallpaper,
        ),
      ],
    );
  }
}
