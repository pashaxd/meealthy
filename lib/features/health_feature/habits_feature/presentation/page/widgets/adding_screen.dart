import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meealthy/features/health_feature/activity_feature/presentation/widgets/adding_button.dart';
import 'package:meealthy/features/health_feature/activity_feature/presentation/widgets/adding_info_widget.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';

class AddingHabitScreen extends StatelessWidget {
  const AddingHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 246, 204),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Add habits', style: TextStyles.defaultMiddleStyle),
        backgroundColor: const Color.fromARGB(255, 204, 246, 204),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            AddingInfoWidget(
              title: 'Habits',
              description:
                  'The result of regular aerobics classes is to keep the body toned, to train muscles and skin, and to improve the overall health of the body',
              children: [
                AddingButton(title: 'Bath with magnesium salt'),
                AddingButton(title: 'Breathing exercises'),
                AddingButton(title: 'Sleep mode'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
