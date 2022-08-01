/// This code belongs to Plannit LLC.
/// Copyright © 2020 by Plannit LLC. All rights reserved.

// import libraries
import 'package:flutter/cupertino.dart';
import 'dart:convert';

// import classes
import 'package:plannit_frontend/models/category_specific_data.dart';

class MyPlanData extends ChangeNotifier {
  String planId; // need
  bool isPublic; // need
  bool hasCollab;
  String planName; // need
  int budget; // don't need at the moment
  int duration; // not needing at the moment
  String planCreatorId; // need (email or username??)
  List invitees; // need
  List<CategorySpecificData> planContents; // NEED

  MyPlanData({
    this.planId,
    this.planName = "Tên kế hoạch",
    this.isPublic,
    this.hasCollab,
    //this.budget,
    //this.duration,
    this.planCreatorId,
    this.invitees,
    this.planContents,
  });

  // Add collaborators to plan
  void addInvitees(List invitees) {
    invitees = invitees;
    notifyListeners();
  }

  String inviteesToString() {
    String str = "";
    invitees.forEach((element) {str += element + ",";});
    print("DEBUG in MyPlanData: " + str);
    return str;
  }

  List<dynamic> get getInvitees => invitees;

  // Add activity to category
  void add(CategorySpecificData activity) {
    planContents.add(activity);
    notifyListeners();
  }

  // Remove activity from category
  void remove(int index) {
    planContents.removeAt(index);
    notifyListeners();
  }

  // Switch lock status (T vs. F) of certain category
  void modifyLock(int index) {
    planContents.elementAt(index).modifyLock();
    notifyListeners();
  }

  // Switch collab mode (T vs. F) of current plan
  void modifyCollab() {
    hasCollab = !hasCollab;
    notifyListeners();
  }

  // Add chosen items into certain category of index
  void addChosenExplore(int index, Map<String, dynamic> chosenOnes) {
    planContents.elementAt(index).exploreIdList = chosenOnes;
    notifyListeners();
  }

  // Remove chosen item into certain category of index
  void delChosenExplore(int index, String chosenOne) {
    planContents.elementAt(index).exploreIdList.remove(chosenOne);
    notifyListeners();
  }

  // Check if user liked item
  bool likedItem(int index, String userId, String itemId) {
    List exploreIdList = planContents.elementAt(index).exploreIdList[itemId];
    return exploreIdList != null ? exploreIdList.contains(userId) : false;
  }

  // Get number of likes for this item
  int getLikeNum(int index, String itemId) {
    List exploreIdList = planContents.elementAt(index).exploreIdList[itemId];
    return exploreIdList != null ? exploreIdList.length : 0;
  }

  // Network-related factories
  Map<String, dynamic> toJson() {
    List<Map> contents = this.planContents != null
        ? this.planContents.map((e) => e.toJson()).toList()
        : null;

    return {
      'name': planName,
      'isPublic': isPublic,
      'hasCollab': hasCollab,
      'contents': contents,
      'creator_id': planCreatorId,
      'collaborators': getInvitees,
    };
  }

  factory MyPlanData.fromJson(Map<String, dynamic> json, String planId) {
    // extract contents of current plan
    List<CategorySpecificData> contentList = [];

    if (json['contents'] != null)
      for(var i = 0; i < json['contents'].length; i++) {
        CategorySpecificData catData = CategorySpecificData.fromJson(json['contents'][i]);
        contentList.add(catData);
      }

    return MyPlanData(
      planId: planId,
      planName: json['name'],
      isPublic: json['isPublic'],
      hasCollab: json['hasCollab'],
      planCreatorId: json['creator_id'],
      invitees: json['collaborators'],
      planContents: contentList,
    );
  }
}
