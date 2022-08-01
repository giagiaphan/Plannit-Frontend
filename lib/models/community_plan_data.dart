import 'package:flutter/cupertino.dart';

import 'package:plannit_frontend/models/category_specific_data.dart';
import 'package:plannit_frontend/models/my_saved_plans.dart';


class CommunityPlanData extends ChangeNotifier{
  final String planName;
  final int budget;
  List<String> duration;
  final String planCreator;
  List<String> invitees;
  List<CategorySpecificData> _planContents;

  List<CategorySpecificData> get planContents => _planContents;

  CommunityPlanData({
    this.planName,
    this.budget,
    this.duration,
    this.planCreator,
    this.invitees
  });

  void add(CategorySpecificData activity) {
    _planContents.add(activity);
    notifyListeners();
  }

  void remove(int index) {
    _planContents.removeAt(index);
    notifyListeners();
  }
}