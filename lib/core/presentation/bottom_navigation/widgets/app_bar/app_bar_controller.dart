import 'package:get/get.dart';

class AppBarController extends GetxController {
  final RxInt selectedDayIndex = 0.obs;
  final RxInt selectedTabIndex = 0.obs;

  void setSelectedDay(int index) {
    selectedDayIndex.value = index;
  }

  void setSelectedTab(int index) {
    selectedTabIndex.value = index;
  }
}
