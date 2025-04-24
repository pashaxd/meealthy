import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxDouble opacity = 1.0.obs;
  late final PageController pageController;

  final List<String> _routes = [
    Routes.HEALTH,
    Routes.MEEALTHY,
    Routes.STATS,
    Routes.TESTS,
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> changePage(int index) async {
    if (index == selectedIndex.value) return;
    
    opacity.value = 0;
    await Future.delayed(const Duration(milliseconds: 150));
    selectedIndex.value = index;
    opacity.value = 1;
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  void updateIndexFromRoute(String route) {
    final index = _routes.indexOf(route);
    if (index != -1) {
      selectedIndex.value = index;
    }
  }
} 