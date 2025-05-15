import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meealthy/features/health_feature/activity_feature/presentation/page/mark_time_screen.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';

class AddingButton extends StatelessWidget {
  const AddingButton({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        minimumSize: MaterialStatePropertyAll(Size.zero),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        Get.to(() => MarkTimeScreen(title: title));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black),
        ],
      ),
    );
  }
}
