import 'package:flutter/material.dart';
import 'package:plannit_frontend/models/community_plan_data.dart';
import 'my_plan_data.dart';

class CommunitySavedPlans extends ChangeNotifier {
  static List<CommunityPlanData> savedList = [];

  List<CommunityPlanData> get plans => savedList;

  static void add() {
    savedList.add(new CommunityPlanData(
        planName: "Date night at Ho Guom",
        budget: 2020,
        planCreator: "Jessica Wildfire"));
  }

  void remove(int index) {
    savedList.removeAt(index);
    notifyListeners();
  }
}