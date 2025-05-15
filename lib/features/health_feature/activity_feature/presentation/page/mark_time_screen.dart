import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meealthy/core/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:meealthy/features/health_feature/activity_feature/presentation/page/activity_widget.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';

class MarkTimeScreen extends StatelessWidget {
  final String title;
  MarkTimeScreen({super.key, required this.title}) {
    // Initialize controllers with default values
    hourController.jumpToItem(0);
    minuteController.jumpToItem(0);
    timeController.setSelectedHourIndex(0);
    timeController.setSelectedMinuteIndex(0);
  }

  final List<int> hours = List.generate(24, (index) => index).obs;
  final List<int> minutes = List.generate(60, (index) => index).obs;
  final FixedExtentScrollController hourController =
      FixedExtentScrollController();
  final FixedExtentScrollController minuteController =
      FixedExtentScrollController();

  final timeController = Get.find<TimeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 210, 204, 246),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(title, style: TextStyles.defaultMiddleStyle),
        backgroundColor: const Color.fromARGB(255, 210, 204, 246),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Mark your training time',
                    style: TextStyles.defaultMiddleStyle,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'How to make $title',
                              style: TextStyles.defaultMiddleStyle,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromRGBO(238, 246, 204, 1),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 16, left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'How to do the exercise',
                                      style: TextStyles.defaultMiddleStyle,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ],
                                ),
                                Text(
                                  'Click and learn how to do the exercise correctly if you\'ve never done it before',
                                  style: TextStyles.defaultLittleStyle,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.32,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Image.asset(
                              'assets/pngs/how_to_do.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                // Барабаны времени
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 90,
                          height: 300,
                          child: ListWheelScrollView.useDelegate(
                            useMagnifier: true,
                            magnification: 1.2,
                            overAndUnderCenterOpacity: 0.4,
                            controller: hourController,
                            itemExtent: 60,
                            perspective: 0.005,
                            diameterRatio: 2.0,
                            physics: FixedExtentScrollPhysics(
                              parent: BouncingScrollPhysics(),
                            ),
                            onSelectedItemChanged: (index) {
                              timeController.setSelectedHourIndex(index);
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                if (index == null ||
                                    index < 0 ||
                                    index >= hours.length)
                                  return null;

                                return Center(
                                  child: Obx(() {
                                    final selectedIndex =
                                        timeController.selectedHourIndex.value;
                                    final distance =
                                        (index - selectedIndex).abs();
                                    final scale =
                                        1.0 - (distance * 0.2).clamp(0.0, 0.7);

                                    return Transform.scale(
                                      scale: scale,
                                      child: Text(
                                        '${hours[index].toString()}',
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(
                                            scale,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                              childCount: hours.length,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(':', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 90,
                          height: 300,
                          child: ListWheelScrollView.useDelegate(
                            useMagnifier: true,
                            magnification: 1.2,
                            overAndUnderCenterOpacity: 0.4,
                            controller: minuteController,
                            itemExtent: 60,
                            perspective: 0.005,
                            diameterRatio: 2.0,
                            physics: FixedExtentScrollPhysics(
                              parent: BouncingScrollPhysics(),
                            ),
                            onSelectedItemChanged: (index) {
                              timeController.setSelectedMinuteIndex(index);
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                if (index == null ||
                                    index < 0 ||
                                    index >= minutes.length)
                                  return null;

                                return Center(
                                  child: Obx(() {
                                    final selectedIndex =
                                        timeController
                                            .selectedMinuteIndex
                                            .value;
                                    final distance =
                                        (index - selectedIndex).abs();
                                    final scale =
                                        1.0 - (distance * 0.2).clamp(0.0, 0.7);

                                    return Transform.scale(
                                      scale: scale,
                                      child: Text(
                                        minutes[index].toString(),
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(
                                            scale,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                              childCount: minutes.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Квадратик для выбранного значения (центральный overlay)
                    IgnorePointer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                0,
                              ), // или Colors.transparent
                              border: Border.all(
                                color: Colors.black12,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ), // ширина между барабанами + ширина двоеточия
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                0,
                              ), // или Colors.transparent
                              border: Border.all(
                                color: Colors.black12,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 24),
                // ElevatedButton(
                //   onPressed: () {
                //     final hour = hours[hourController.selectedItem];
                //     final minute = minutes[minuteController.selectedItem];
                //     timeController.setTime(hour, minute);
                //     Get.snackbar(
                //       'Время сохранено',
                //       'Вы выбрали $hour ч $minute мин',
                //     );
                //     // Можно сделать переход на другой экран, если нужно:
                //     // Get.to(() => ActivityScreen());
                //   },
                //   child: Text('Сохранить'),
                // ),
                // Obx(
                //   () => Text(
                //     'Выбранное время: ${hours[hourController.selectedItem]} ч ${minutes[minuteController.selectedItem]} мин',
                //     style: TextStyle(fontSize: 18),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.14,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                timeController.reset();
                Get.to(() => BottomNavigation());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Save', style: TextStyles.defaultButtonStyle),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Obx(
                      () => Text(
                        '${timeController.hour.value} h ${timeController.minute.value} min',
                        style: TextStyles.defaultButtonStyle,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeController extends GetxController {
  RxInt hour = 0.obs;
  RxInt minute = 0.obs;
  RxInt selectedHourIndex = 0.obs;
  RxInt selectedMinuteIndex = 0.obs;

  void setTime(int h, int m) {
    hour.value = h;
    minute.value = m;
  }

  void setSelectedHourIndex(int index) {
    selectedHourIndex.value = index;
    hour.value = index;
  }

  void setSelectedMinuteIndex(int index) {
    selectedMinuteIndex.value = index;
    minute.value = index;
  }

  void reset() {
    hour.value = 0;
    minute.value = 0;
    selectedHourIndex.value = 0;
    selectedMinuteIndex.value = 0;
  }
}
