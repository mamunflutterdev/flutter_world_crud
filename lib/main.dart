import 'package:flutter/material.dart';
import 'package:flutter_world_crud/screens/home_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          toolbarHeight: 80,
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            foregroundColor: Colors.white
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

