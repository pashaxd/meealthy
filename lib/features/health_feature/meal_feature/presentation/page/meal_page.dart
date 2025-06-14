import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meealthy/core/presentation/bottom_navigation/widgets/app_bar/app_bar_controller.dart';
import 'package:meealthy/features/health_feature/meal_feature/presentation/controllers/health_controller.dart';
import 'package:meealthy/features/health_feature/meal_feature/presentation/widgets/meal_card.dart';
import 'package:meealthy/features/health_feature/meal_feature/presentation/widgets/meal_container.dart';

class MealPage extends StatelessWidget {
  final RxDouble waterIntake = 0.0.obs;
  final int totalGlasses = 8;
  final HealthController healthController = Get.find<HealthController>();
  final AppBarController appBarController = Get.find<AppBarController>();
  MealPage({Key? key}) : super(key: key);

  void _addWater(double amount) {
    waterIntake.value = (waterIntake.value + amount).clamp(0.0, 2000.0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.68,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (healthController.selectedTab.value == 0 &&
                  appBarController.selectedDayIndex.value == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.14,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 204, 215, 246),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Check your water balance today',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                child: const Center(
                                  child: Text(
                                    '?',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => _addWater(250),
                            child: Obx(() {
                              final filledGlasses = (waterIntake.value / 250)
                                  .floor()
                                  .clamp(0, totalGlasses);
                              return Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List.generate(totalGlasses, (index) {
                                  return SvgPicture.asset(
                                    'assets/svgs/cup.svg',
                                    width: 31,
                                    height: 30,
                                    colorFilter: ColorFilter.mode(
                                      index < filledGlasses
                                          ? Colors.blue
                                          : Colors.black12,
                                      BlendMode.srcIn,
                                    ),
                                  );
                                }),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            // Контейнер с едой
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 246, 204),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/star.svg',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Meal for you',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          MealContainer(
                            date: '8.00 AM',
                            meals: [
                              MealCard(
                                title: 'Breakfast',
                                shortDescription: 'Cherry smoothie with chia',
                                iconPath: 'assets/svgs/breakfast.svg',
                              ),
                              MealCard(
                                title: 'Breakfast',
                                shortDescription: 'Cherry smoothie with chia',
                                iconPath: 'assets/svgs/breakfast.svg',
                              ),
                            ],
                          ),
                          MealContainer(
                            date: '8.00 AM',
                            meals: [
                              MealCard(
                                title: 'Breakfast',
                                shortDescription: 'Cherry smoothie with chia',
                                iconPath: 'assets/svgs/breakfast.svg',
                              ),
                              MealCard(
                                title: 'Breakfast',
                                shortDescription: 'Cherry smoothie with chia',
                                iconPath: 'assets/svgs/breakfast.svg',
                              ),
                            ],
                          ),
                          MealContainer(
                            date: '8.00 AM',
                            meals: [
                              MealCard(
                                title: 'Breakfast',
                                shortDescription: 'Cherry smoothie with chia',
                                iconPath: 'assets/svgs/breakfast.svg',
                              ),
                              MealCard(
                                title: 'Breakfast',
                                shortDescription: 'Cherry smoothie with chia',
                                iconPath: 'assets/svgs/breakfast.svg',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Отступ для bottom navigation bar
            SizedBox(height: kBottomNavigationBarHeight),
          ],
        ),
      ),
    );
  }
}
