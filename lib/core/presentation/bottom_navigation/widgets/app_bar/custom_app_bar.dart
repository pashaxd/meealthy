import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'app_bar_controller.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final AppBarController controller = Get.put(AppBarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.1,
      color: Colors.grey[300],
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(

              horizontal: MediaQuery.of(context).size.height*0.025),
          child: Row(
            children: [
              // Day selector
              Expanded(
                child: Row(
                  children: [
                    _buildDayButton('Today', 0),
                    const SizedBox(width: 16),
                    _buildDayButton('Tomorrow', 1),
                  ],
                ),
              ),
              // Notification and profile
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayButton(String text, int index) {
    return Obx(() {
      final isSelected = controller.selectedDayIndex.value == index;
      return GestureDetector(
        onTap: () => controller.setSelectedDay(index),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
      );
    });
  }
}
