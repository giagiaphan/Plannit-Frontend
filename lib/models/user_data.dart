import 'package:flutter/foundation.dart';

/// This code belongs to Plannit LLC.
/// Copyright © 2020 by Plannit LLC. All rights reserved.


class UserData extends ChangeNotifier {
  String userId;
  String username;
  String email;
  String phone_no;
  String planning_since;
  List<dynamic> friends;
  double rating_average;
  int review_count;
  int public_plan_count;
  int followers;
  int following;

  UserData({
    this.userId,
    this.username,
    this.email,
    this.phone_no,
    this.planning_since,
    this.friends,
    this.rating_average,
    this.review_count,
    this.public_plan_count,
    this.followers,
    this.following,
  });

  factory UserData.fromJson(Map<String, dynamic> json, String userId) {
    return UserData(
      userId: userId,
      username: json['username'],
      email: json['email'],
      phone_no: json['phone'],
      planning_since: json['planning_since'],
      friends: json['friends'],
      rating_average: json['rating_average'] * 1.0,
      review_count: json["review_count"],
      public_plan_count: json["public_plan_count"],
      followers: json['followers'],
      following: json['following'],
    );
  }
}