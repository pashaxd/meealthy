import 'package:get/get.dart';

class HabitItem {
  final String name;

  HabitItem({required this.name});
}

class HabitsController extends GetxController {
  final RxList<HabitItem> habits = <HabitItem>[].obs;

  void addHabit(String name) {
    habits.add(HabitItem(name: name));
  }

  void removeHabit(int index) {
    if (index >= 0 && index < habits.length) {
      habits.removeAt(index);
    }
  }

  void clearHabits() {
    habits.clear();
  }
}
