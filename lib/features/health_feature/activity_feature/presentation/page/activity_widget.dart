import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meealthy/features/health_feature/activity_feature/presentation/page/adding_screen.dart';
import 'package:meealthy/features/health_feature/activity_feature/presentation/page/mark_time_screen.dart';
import 'package:meealthy/features/health_feature/meal_feature/presentation/widgets/meal_card.dart';
import 'package:meealthy/features/health_feature/meal_feature/presentation/widgets/meal_container.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timeController = Get.find<TimeController>();

    return Column(
      children: [
        Container(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 210, 204, 246),
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
                        'Exercise for you',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'These recommendations are made specifically for you, based on the results of your test',
                    style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                Get.to(() => const AddingScreen());
              },
              child: Text('Add activity', style: TextStyles.defaultButtonStyle),
            ),
          ),
        ),
      ],
    );
  }
}
