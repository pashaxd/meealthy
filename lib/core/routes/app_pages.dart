import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meealthy/features/auth_feature/presentation/screen/auth_screen.dart';
import 'package:meealthy/features/auth_feature/presentation/screen/first_screen.dart';
import 'package:meealthy/features/health_feature/screen/health_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.AUTH;

  static final routes = [
   
    GetPage(
      name: Routes.HEALTH,
      page: () => const HealthScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.MEEALTHY,
      page: () => const Center(child: Text('Meealthy Page')),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.STATS,
      page: () => const Center(child: Text('Stats Page')),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.TESTS,
      page: () => const Center(child: Text('Tests Page')),
      transition: Transition.fadeIn,
    ),
  ];
} 