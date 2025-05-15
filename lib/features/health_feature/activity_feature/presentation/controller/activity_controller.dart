import 'package:get/get.dart';

class ActivityItem {
  final String name;
  final String time;

  ActivityItem({required this.name, required this.time});
}

class ActivityController extends GetxController {
  final RxList<ActivityItem> activities = <ActivityItem>[].obs;

  void addActivity(String name, String time) {
    activities.add(ActivityItem(name: name, time: time));
  }

  void removeActivity(int index) {
    if (index >= 0 && index < activities.length) {
      activities.removeAt(index);
    }
  }

  void clearActivities() {
    activities.clear();
  }
}
