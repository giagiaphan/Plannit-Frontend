/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

// import classes
import 'package:plannit_frontend/models/my_plan_data.dart';
import 'package:plannit_frontend/screens/inner_layers/saved_inner_layers/invited_plan_editor.dart';
import '../main.dart';

class SavedCustomListItem extends StatelessWidget {
  final currUserId;
  final plan;

  SavedCustomListItem({
    this.currUserId,
    this.plan,
  });

  final snackBar = SnackBar(
    content: Text('Đã xóa kế hoạch của bạn thành công!'),
  );

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference plans = FirebaseFirestore.instance.collection('plans');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: users.doc(plan.planCreatorId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: SvgPicture.asset(
                        'assets/icons/OFFICIAL_LOGO.svg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: PlanDescription(
                      title: plan.planName,
                      planCreator: snapshot.data.data()['username'],
                      //viewCount: myCurrPlan.budget,
                    ),
                  ),
                  Column(
                    children: [
                      // IconButton(
                      //   icon: Icon(Icons.more_horiz),
                      //   onPressed: () {},
                      // ),
                      IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () {
                          //deletePlan(myCurrPlan.planId);
                          // if current user is the plan's creator,
                          // then has permission to delete
                          if (currUserId == plan.planCreatorId) {
                            Widget okButton = FlatButton(
                              child: Text(
                                "Xóa",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: () {
                                plans
                                    .doc(plan.planId)
                                    .delete()
                                    .then((value) => print("Plan Deleted"))
                                    .catchError((error) =>
                                    print("Failed to delete plan: $error"));
                                Navigator.of(context).pop();

                                // show snackbar informing user that plan deleted
                                Scaffold.of(context).showSnackBar(snackBar);
                              },
                            );

                            Widget noButton = FlatButton(
                              child: Text(
                                "Hủy",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("Xóa kế hoạch"),
                              content:
                              Text("Bạn có chắc muốn xóa kế hoạch này?"),
                              actions: [
                                okButton,
                                noButton,
                              ],
                            );

                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                            //del plan

                          } else {
                            // otherwise, f you
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Xóa kế hoạch"),
                                  content: Text(
                                      "Bạn không có quyển để xóa kế hoạch này"),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, return a loading spinner
        return CircularProgressIndicator();
      },
    );
  }
}

class PlanDescription extends StatelessWidget {
  const PlanDescription({
    Key key,
    this.title,
    this.planCreator,
    //this.viewCount,
  }) : super(key: key);

  final String title;
  final String planCreator;

  //final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            'by $planCreator',
            style: const TextStyle(fontSize: 10.0),
          ),
          // const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          // Text(
          //   '$viewCount views',
          //   style: const TextStyle(fontSize: 10.0),
          // ),
        ],
      ),
    );
  }
}
