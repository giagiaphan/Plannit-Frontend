import 'package:flutter/material.dart';
import 'my_plan_data.dart';

class MySavedPlans extends ChangeNotifier {
  static List<MyPlanData> savedList = [];

  List<MyPlanData> get plans => savedList;

  static add(MyPlanData plan) {
    savedList.add(plan);
  }

  void remove(int index) {
    savedList.removeAt(index);
    notifyListeners();
  }
}