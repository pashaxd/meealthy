import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meealthy/features/health_feature/activity_feature/presentation/page/activity_widget.dart';
import 'package:meealthy/features/health_feature/habits_feature/presentation/page/habits_widget.dart';
import 'package:meealthy/features/health_feature/meal_feature/presentation/controllers/health_controller.dart';
import 'package:meealthy/features/health_feature/meal_feature/presentation/page/meal_page.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HealthController());

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.025),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.025,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => ElevatedButton(
                        style: ButtonStyle(
                          elevation: WidgetStatePropertyAll(0),
                          backgroundColor: WidgetStatePropertyAll(
                            controller.selectedTab.value == 0
                                ? Colors.white
                                : Colors.grey[300],
                          ),
                        ),
                        onPressed: () => controller.changeTab(0),
                        child: Text(
                          'Meal',
                          style: TextStyles.defaultLittleStyle,
                        ),
                      ),
                    ),
                    Obx(
                      () => ElevatedButton(
                        style: ButtonStyle(
                          elevation: WidgetStatePropertyAll(0),
                          backgroundColor: WidgetStatePropertyAll(
                            controller.selectedTab.value == 1
                                ? Colors.white
                                : Colors.grey[300],
                          ),
                        ),
                        onPressed: () => controller.changeTab(1),
                        child: Text(
                          'Activity',
                          style: TextStyles.defaultLittleStyle,
                        ),
                      ),
                    ),
                    Obx(
                      () => ElevatedButton(
                        style: ButtonStyle(
                          elevation: WidgetStatePropertyAll(0),
                          backgroundColor: WidgetStatePropertyAll(
                            controller.selectedTab.value == 2
                                ? Colors.white
                                : Colors.grey[300],
                          ),
                        ),
                        onPressed: () => controller.changeTab(2),
                        child: Text(
                          'Habits',
                          style: TextStyles.defaultLittleStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Expanded(
              child: Stack(
                children: [
                  Obx(() {
                    final selectedTab = controller.selectedTab.value;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      transform: Matrix4.translationValues(
                        0,
                        selectedTab == -1
                            ? MediaQuery.of(context).size.height
                            : 0,
                        0,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [_getContentForTab(selectedTab)],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getContentForTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return MealPage();
      case 1:
        return ActivityWidget();
      case 2:
        return HabitsWidget();
      default:
        return const SizedBox();
    }
  }
}
