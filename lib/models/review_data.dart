import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ReviewData extends ChangeNotifier {
  String review_id;
  int rating; // rating of business by user
  String text; // review content
  String business_id; // business id
  String reviewer_id;
  String review_at;
  List<dynamic> pictures;

  ReviewData({
    this.review_id,
    this.rating,
    this.text,
    this.business_id,
    this.reviewer_id,
    this.review_at,
    this.pictures,
  });

  // factories for ReviewData
  static Map<String, dynamic> toJson(String business, String text, int rating,
      String reviewer_id, List<String> pictures) {
    return {
      'business': business,
      'text': text,
      'rating': rating,
      'reviewer_id': reviewer_id,
      'pictures': pictures,
      'review_at': DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
    };
  }

  factory ReviewData.fromJson(QueryDocumentSnapshot json) {
    return ReviewData(
      review_id: json.id,
      business_id: json['business'],
      rating: json['rating'],
      reviewer_id: json['reviewer_id'],
      text: json['text'],
      pictures: json['pictures'],
      review_at: json['review_at'],
    );
  }
}
