/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

//import libraries
import 'package:flutter/material.dart';
import 'package:plannit_frontend/screens/inner_layers/new_plan_inner_layers/new_plan.dart';

//import classes
import 'package:plannit_frontend/screens/inner_layers/saved_inner_layers/saved_my_plans.dart';
import 'package:plannit_frontend/screens/inner_layers/saved_inner_layers/saved_invited_plans.dart';

class SavedWidget extends StatefulWidget {
  @override
  _SavedWidgetState createState() => _SavedWidgetState();
}

class _SavedWidgetState extends State<SavedWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text("Kế hoạch"),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black12.withOpacity(0.3),
            indicatorColor: Color(0xffffcbc2),
            tabs: [
              Tab(
                text: 'Của tôi',
              ),
              Tab(
                text: 'Được mời',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlanCreator(),
              ),
            );
          },
          icon: Icon(Icons.add),
          label: Text("Tạo kế hoạch mới"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: TabBarView(
          children: [
            MyPlan(),
            InvitedPlan(),
          ],
        ),
      ),
    );
  }
}
