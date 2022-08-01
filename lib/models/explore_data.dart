/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

import 'package:intl/intl.dart';

class ExploreData {
  final List business_pic;
  final String business_id;
  final String name;
  final double rating;
  final String address;
  final String district;
  final String city;
  final double latitude;
  final double longtitude;
  final String open_hours;
  final int review_count;

  ExploreData({
    this.business_pic,
    this.business_id,
    this.name,
    this.rating,
    this.address,
    this.district,
    this.city,
    this.latitude,
    this.longtitude,
    this.open_hours,
    this.review_count,
  });



  factory ExploreData.fromJson(Map<String, dynamic> json) {
    // Getting today's open hours of the Explore item
    String todayDateOfWeek = DateFormat('EEEE').format(DateTime.now()).toString();

    Map dateOfWeekMap = {
      'Monday': 'M',
      'Tuesday': 'T',
      'Wednesday': 'W',
      'Thursday': 'Th',
      'Friday': 'F',
      'Saturday': 'Sat',
      'Sunday': 'Sun',
    };

    return ExploreData(
      business_pic: json['bus_photo_url'],
      business_id: json['objectID'],
      name: json['name'],
      rating: json['avg_rating'] * 1.0,
      address: json['address'],
      district: json['district'],
      city: json['city'],
      longtitude: 1.0, //json['longtitude'],
      latitude: 1.0, //json['latitude'],
      open_hours: json['hours'][dateOfWeekMap[todayDateOfWeek]],
      review_count: json['review_count'],
    );
  }
}