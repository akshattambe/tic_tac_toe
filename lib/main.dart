import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/main_screen.dart';
import 'package:tic_tac_toe/theme/theme.dart';
import 'package:tic_tac_toe/widgets/wallpaper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      builder: (context, child) {
        return Wallpaper(child: child!);
      },
      home: const MainScreen(),
    );
  }
}