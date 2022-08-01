/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

//import libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

//import classes
import 'package:plannit_frontend/models/my_plan_data.dart';
import 'package:plannit_frontend/components/plan_editor_components.dart';


class MySavedEditor extends StatefulWidget {
  final currPlan;
  final currUserId;

  MySavedEditor({
    this.currPlan,
    this.currUserId,
  });

  @override
  _MySavedEditorState createState() => _MySavedEditorState();
}

class _MySavedEditorState extends State<MySavedEditor> {
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
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        MyPlanData currPlan = MyPlanData.fromJson(
          snapshot.data.data(),
          widget.currPlan.planId,
        );

        return ChangeNotifierProvider.value(
          value: currPlan,
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
                        // Theme background of expanded part
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Color(0xfffff5f5),
                        ),

                        // Util bar
                        UpperUtilBar(inSaved: true,),
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
                                top: 10, left: 10, right: 10, bottom: 20,),
                            child: Column(
                              children: [
                                CategoryUtilRow(
                                  titleTheme: titleTheme,
                                  currCatIndex: index,
                                  inSaved: true,
                                  inPlanEditor: true,
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
            floatingActionButton: FabButton(initPlan: false,),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
        );
      },
    );
  }
}