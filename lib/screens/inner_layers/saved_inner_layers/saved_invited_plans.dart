/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import classes
import 'package:plannit_frontend/components/my_saved_components.dart';
import 'package:plannit_frontend/models/my_plan_data.dart';
import 'invited_plan_editor.dart';

class InvitedPlan extends StatelessWidget {
  final uid = FirebaseAuth.instance.currentUser.uid;

  CollectionReference plans = FirebaseFirestore.instance.collection('plans');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: plans
          .where('collaborators', arrayContains: uid)
          .where('hasCollab', isEqualTo: true)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemExtent: 106.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              MyPlanData invitedPlan = MyPlanData.fromJson(
                snapshot.data.documents[index].data(),
                snapshot.data.documents[index].id,
              );

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvitedPlanEditor(
                        currPlan: invitedPlan,
                        currUserId: uid,
                      ),
                    ),
                  );
                },
                child: SavedCustomListItem(
                  currUserId: uid,
                  plan: invitedPlan,
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner
        return CircularProgressIndicator();
      },
    );
  }
}