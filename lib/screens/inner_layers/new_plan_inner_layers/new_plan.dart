/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

//import libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

//import classes
import 'package:plannit_frontend/models/my_plan_data.dart';
import 'package:plannit_frontend/components/email_authentication_banner.dart';
import 'package:plannit_frontend/components/plan_editor_components.dart';
import 'package:plannit_frontend/screens/inner_layers/new_plan_inner_layers/categories.dart';

class PlanCreator extends StatefulWidget {
  @override
  _PlanCreatorState createState() => _PlanCreatorState();
}

class _PlanCreatorState extends State<PlanCreator> {
  @override
  Widget build(BuildContext context) {
    final TextStyle titleTheme = Theme.of(context).textTheme.headline6;

    final uid = FirebaseAuth.instance.currentUser.uid;

    return ChangeNotifierProvider(
      create: (context) => MyPlanData(
        isPublic: false,
        hasCollab: true,
        invitees: [],
        planContents: [],
        planCreatorId: uid,
      ),
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          // controller: _scrollController,
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

                    Column(
                      children: [
                        // Util bar
                        UpperUtilBar(inSaved: false,),

                        // Display a banner if user's email is not verified
                        // w/ button for resending the auth email
                        if (!FirebaseAuth.instance.currentUser.emailVerified)
                          EmailAuthenticationBanner(),
                      ],
                    ),
                  ],
                ),
              ),
              expandedHeight:
                  FirebaseAuth.instance.currentUser.emailVerified ? 130 : 300,
            ),
            Consumer<MyPlanData>(
              builder: (context, myNewPlan, child) {
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
                              inSaved: false,
                              inPlanEditor: true,
                            ),
                            BusinessBoxPageView(
                              catSpecificData: myNewPlan.planContents[index],
                              currCatIndex: index,
                              titleTheme: titleTheme,
                              inSaved: false,
                              needVoteAndDel: false,
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: myNewPlan.planContents.length,
                  ),
                  // onReorder: _onReorder,
                );
              },
            ),
          ],
        ),
        floatingActionButton: FabButton(initPlan: true,),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
