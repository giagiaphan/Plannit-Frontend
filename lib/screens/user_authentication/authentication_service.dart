/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  final dbRef = FirebaseFirestore.instance;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  User get currentUser => _firebaseAuth.currentUser;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn(
      {String email, String password, BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return "Signed in";
    } on FirebaseAuthException catch (e) {
      print("On signing in, " + e.message);
      return "Error on signing in";
    }
  }

  Future<String> signUp(
      {String email, String password, String username, String phone_no}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => dbRef
              .collection('users')
              .doc(_firebaseAuth.currentUser.uid)
              .set({
                'email': email,
                'username': username,
                'phone_no': phone_no,
                'planning_since':
                    DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
                'friends': [],
                'rating_average': 0.0,
                'review_count': 0,
                'public_plan_count': 0,
                'followers': 0,
                'following': 0,
              })
              .then((value) => print("User Added"))
              .catchError((error) => print("Failed to add user: $error")));

      // Sending verification email to user's email
      try {
        await currentUser.sendEmailVerification();
        await signOut();
        print("Verification email sent");
      } catch (e) {
        print("An error occured while trying to send email verification");
        print(e);
      }

      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
