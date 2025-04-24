import 'package:get/get.dart';

class HealthController extends GetxController {
  final RxInt selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void hide() {
    selectedTab.value = -1;
  }
} 