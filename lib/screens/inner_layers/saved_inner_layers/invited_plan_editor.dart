/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

//import libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

//import classes
import 'package:plannit_frontend/models/my_plan_data.dart';
import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/explore_individual_item.dart';
import 'package:plannit_frontend/screens/inner_layers/saved_inner_layers/see_collaborator.dart';
import 'package:plannit_frontend/components/plan_editor_components.dart';


class InvitedPlanEditor extends StatefulWidget {
  final currPlan;
  final currUserId;

  InvitedPlanEditor({
    this.currPlan,
    this.currUserId,
  });

  @override
  _InvitedPlanEditorState createState() => _InvitedPlanEditorState();
}

class _InvitedPlanEditorState extends State<InvitedPlanEditor> {
  Stream planStream;

  @override
  void initState() {
    planStream = FirebaseFirestore.instance
        .collection('plans')
        .doc(widget.currPlan.planId)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle titleTheme = Theme.of(context).textTheme.headline6;

    return StreamBuilder<DocumentSnapshot>(
      stream: planStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        MyPlanData invitedPlan =
            MyPlanData.fromJson(snapshot.data.data(), widget.currPlan.planId);

        return ChangeNotifierProvider.value(
          value: invitedPlan,
          child: Scaffold(
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Color(0xfffff5f5),
                        ),
                        UpperPlanBar(),
                      ],
                    ),
                  ),
                  expandedHeight: 130,
                ),
                Consumer<MyPlanData>(
                  builder: (context, mySavedPlan, _) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 20),
                            child: Column(
                              children: [
                                CategoryUtilRow(
                                  titleTheme: titleTheme,
                                  currCatIndex: index,
                                ),
                                BusinessBoxPageView(
                                  catSpecificData:
                                  mySavedPlan.planContents[index],
                                  titleTheme: titleTheme,
                                  currCatIndex: index,
                                  inSaved: true,
                                  needVoteAndDel: true,
                                  //currUserId: widget.currUserId,
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: mySavedPlan.planContents.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UpperPlanBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyPlanData>(builder: (context, myCurrPlan, _) {
      return Container(
        padding: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                myCurrPlan.planName,
                style: TextStyle(fontSize: 20),
              ),
              GestureDetector(
                onTap: () {
                  //myCurrPlan.initInvitees(0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeeCollaborator(
                        currInvitees: myCurrPlan.getInvitees,
                      ),
                    ),
                  );
                },
                child: Icon(Icons.people),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class CategoryUtilRow extends StatelessWidget {
  final currCatIndex;
  final titleTheme;

  CategoryUtilRow({this.currCatIndex, this.titleTheme});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPlanData>(
      builder: (context, mySavedPlan, _) {
        return Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    mySavedPlan.planContents[currCatIndex].category,
                    style: titleTheme,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  GestureDetector(
                    onTap: () {
                      //mySavedPlan.modifyLock(currCatIndex);
                    },
                    child: mySavedPlan.planContents[currCatIndex].lockStatus
                        ? Icon(
                            Icons.lock_outline,
                            color: Colors.green[900],
                          )
                        : Icon(
                            Icons.lock_open,
                            color: Colors.red[600],
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}