import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gweiland_flutter_task/utils/constants.dart';
import 'package:gweiland_flutter_task/view/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Constants.baseColor),
          useMaterial3: true),
      home: const HomePage(),
    );
  }
}
