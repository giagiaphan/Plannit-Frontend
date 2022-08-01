/// This code belongs to Plannit LLC.
/// Copyright © 2020 by Plannit LLC. All rights reserved.


// import libraries
import 'dart:convert';
import 'package:flutter/cupertino.dart';

// import classes
import 'package:plannit_frontend/models/explore_data.dart';





class CategorySpecificData extends ChangeNotifier {
  final String category; // need
  bool locked; // need
  String time; // don't need at the moment
  int currExploreItem; // what the fuck is this?
  Map<String, dynamic> exploreIdList; // do need very much

  CategorySpecificData({
    this.category,
    this.locked,
    this.exploreIdList,
  });

  // mapping between Vietnamese and English category names
  static Map<String, String> catMap = {
    'Ngày đi': 'Create dates', // change to date adder
    'Địa danh': 'Famous destination',
    'Ăn uống': 'Restaurant & Food & Drinks',
    'Chợ': 'Grocery & Supermarket',
    'Giải trí': 'Entertainment',
    'Mua sắm': 'Shopping',
    'Sức khỏe': 'Health',
    'Di chuyển': 'Automotive',
    'Chỗ ở': 'Lodging'
  };

  // access the language map
  Map<String, String> get catMapping => catMap;


  void set changeCurrItem(int index) => currExploreItem = index;

  int get getCurrExploreItem => currExploreItem;


  // change the status of the category lock
  void modifyLock() {
    this.locked = !this.locked;
    notifyListeners();
  }

  // get the current status of the category lock
  bool get lockStatus => locked;


  // factory creating JSON object
  Map<String, dynamic> toJson() => {
        'category': category,
        'locked': lockStatus,
        'exploreIdList': exploreIdList,
      };

  // factory creating CategorySpecificData object from the JSON object
  factory CategorySpecificData.fromJson(Map<String, dynamic> json) {
    return CategorySpecificData(
      category: json['category'],
      locked: json['locked'],
      exploreIdList: json['exploreIdList'],
    );
  }
}
