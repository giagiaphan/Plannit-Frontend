import 'package:firebase_auth/firebase_auth.dart';

/// This code belongs to Plannit LLC.
/// Copyright © 2020 by Plannit LLC. All rights reserved.

// import libraries
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// import classes
import 'package:plannit_frontend/models/explore_data.dart';
import 'package:plannit_frontend/models/review_data.dart';
import 'package:plannit_frontend/models/user_data.dart';

/// Firestore Collections declarations
CollectionReference users = FirebaseFirestore.instance.collection('users');
CollectionReference plans = FirebaseFirestore.instance.collection('plans');
CollectionReference reviews = FirebaseFirestore.instance.collection('reviews');

final String backend_address = "https://algolia-flask-api.et.r.appspot.com";
//String backend_address = "http://127.0.0.1:5000";

/// Network endpoints for ExploreData
// fetching from Algolia REST API
Future<List<ExploreData>> fetchExploreJson(String query, int page) async {
  try {
    http.Response response = await http
        .get('$backend_address/search-businesses/?query=$query&page=$page');

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<ExploreData> exploreList = await parseExploreJson(response.body);
      return exploreList;
    }
  } catch (error) {
    print("Failed to fetch data: " + query);
    print(error);
  }
}

// parsing data from JSON -> ExploreData objects
List<ExploreData> parseExploreJson(String response) {
  List<ExploreData> exploreList = [];

  if (response == null) {
    return exploreList;
  }

  final parsed = jsonDecode(response.toString());
  parsed['hits'].forEach((map) => {exploreList.add(ExploreData.fromJson(map))});

  return exploreList;
}

// fetch one exact business
Future<ExploreData> fetchOneExplore(String id) async {
  try {
    http.Response response =
        await http.get('$backend_address/get-business/?objectId=$id');

    if (response.statusCode == 200 || response.statusCode == 201) {
      ExploreData exploreItem = await parseOneExplore(response.body);
      return exploreItem;
    }
  } catch (error) {
    print("Failed to fetch explore item: " + id);
    print(error);
  }
}

// parsing data from JSON -> ExploreData objects
ExploreData parseOneExplore(String response) {
  if (response == null) {
    return null;
  }

  final parsed = jsonDecode(response.toString());

  ExploreData exploreItem = ExploreData.fromJson(parsed);

  return exploreItem;
}

/// Network endpoints for UserData
// fetching from Algolia REST API
Future<List<UserData>> fetchUsersJson(String query, int page) async {
  try {
    http.Response response = await http
        .get('$backend_address/search-users/?query=$query&page=$page');

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<UserData> userList = await parseUsersJson(response.body);
      return userList;
    }
  } catch (error) {
    print("Failed to fetch data: " + query);
    print(error);
  }
}

// parsing data from JSON -> ExploreData objects
List<UserData> parseUsersJson(String response) {
  List<UserData> userList = [];

  if (response == null) {
    return userList;
  }

  final parsed = jsonDecode(response.toString());
  //parsed['hits'].forEach((map) => {exploreList.add(UserData.fromJson(map))});

  return userList;
}

// Fetch one user thru their email address
Future<UserData> fetchOneUser(String data) async {
  try {
    http.Response response =
        await http.get('$backend_address/find-user/?data=$data');

    if (response.statusCode == 200 || response.statusCode == 201) {
      UserData user = await parseOneUser(response.body);
      return user;
    }
  } catch (error) {
    print("Failed to fetch user: " + data);
    print(error);
  }
}

UserData parseOneUser(String response) {
  if (response == null) {
    return null;
  }

  final parsed = jsonDecode(response.toString());
  if (parsed['nbHits'] > 0) {
    UserData user =
        UserData.fromJson(parsed['hits'][0], parsed['hits'][0]['objectID']);
    return user;
  }

  return null;
}

/// Network endpoints for ReviewData
// GET review JSON from backend
Future<List<ReviewData>> fetchReviewJson(String businessId) async {
  QuerySnapshot reviewSnapshots =
      await reviews.where('business', isEqualTo: businessId).get();

  List<ReviewData> reviewList = await parseReviewJson(reviewSnapshots);
  return reviewList;
}

// parse JSON -> ReviewData object
List<ReviewData> parseReviewJson(QuerySnapshot response) {
  List<ReviewData> reviewList = [];

  if (response.docs.length == 0) {
    return reviewList;
  }

  response.docs.forEach((map) => {reviewList.add(ReviewData.fromJson(map))});

  return reviewList;
}

/// Save the user's device token
Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  String userId = await FirebaseAuth.instance.currentUser.uid;

  await FirebaseFirestore.instance.collection('users').doc(userId).update({
    'device_tokens': FieldValue.arrayUnion([token]),
  });
}

/// Add collaborators to a plan
Future<void> addCollaborators(String collaborators, String planName) async {
  try {
    http.Response response =
    await http.post('$backend_address/add-collaborators/?plan_name=$planName&collab=$collaborators',
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("Invitations to collaborate in plan sent!");
    }
  } catch (error) {
    print("Failed to send invitations for plan: " + planName);
    print(error);
  }
}
