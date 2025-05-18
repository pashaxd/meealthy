import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meealthy/core/presentation/bottom_navigation/widgets/app_bar/custom_app_bar.dart';
import 'package:meealthy/features/health_feature/screen/health_screen.dart';
import 'package:meealthy/features/mealthy_chat_feature/presentation/chat_screen.dart';
import 'navigation_controller.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  final NavigationController controller = Get.put(NavigationController());

  final List<Widget> _pages = [
    const HealthScreen(),
    ChatScreen(),
    const Center(child: Text('Stats Page')),
    const Center(child: Text('Tests Page')),
  ];

  BottomNavigationBarItem _buildNavItem(
    String svgPath,
    String label,
    bool isSelected,
  ) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        svgPath,
        colorFilter: ColorFilter.mode(
          isSelected ? Colors.black : Colors.grey,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () =>
              controller.selectedIndex.value == 0
                  ? const CustomAppBar()
                  : SizedBox.shrink(),
        ),
      ),
      body: Obx(
        () => AnimatedOpacity(
          opacity: controller.opacity.value,
          duration: const Duration(milliseconds: 150),
          child: IndexedStack(
            index: controller.selectedIndex.value,
            children: _pages,
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: controller.selectedIndex.value,
            onTap: (index) => controller.changePage(index),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedIconTheme: const IconThemeData(
              color: Colors.black,
              size: 24,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.grey.withOpacity(0.5),
              size: 22,
            ),
            selectedLabelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.grey.withOpacity(0.5),
              fontSize: 12,
            ),
            type: BottomNavigationBarType.fixed,
            items: [
              _buildNavItem(
                'assets/svgs/icons_bottom/health.svg',
                'Health',
                controller.selectedIndex.value == 0,
              ),
              _buildNavItem(
                'assets/svgs/icons_bottom/mealthy.svg',
                'Meealthy',
                controller.selectedIndex.value == 1,
              ),
              _buildNavItem(
                'assets/svgs/icons_bottom/stats.svg',
                'Stats',
                controller.selectedIndex.value == 2,
              ),
              _buildNavItem(
                'assets/svgs/icons_bottom/tests.svg',
                'Tests',
                controller.selectedIndex.value == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
