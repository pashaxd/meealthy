import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meealthy/core/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:meealthy/features/auth_feature/presentation/screen/first_screen.dart';
import 'package:meealthy/features/health_feature/activity_feature/presentation/page/mark_time_screen.dart';
import 'package:meealthy/features/health_feature/screen/health_screen.dart';
import 'package:meealthy/features/health_feature/activity_feature/presentation/controller/activity_controller.dart';

void main() {
  Get.put(TimeController());
  Get.put(ActivityController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          //FirstScreen(),
          BottomNavigation(),
    );
  }
}
