/// This code belongs to Plannit LLC.
/// Copyright © 2020 by Plannit LLC. All rights reserved.



// import libraries
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import classes
import 'package:plannit_frontend/models/community_saved_plans.dart';
import 'package:plannit_frontend/screens/inner_layers/community_inner_layers/example_post.dart';
import 'package:plannit_frontend/components/community_saved_components.dart';


class CommunityPlan extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<CommunitySavedPlans>(
      builder: (context, communitySavedPlans, _) {
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemExtent: 106.0,
          itemCount: communitySavedPlans.plans.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExamplePostWidget())
                );
              },
              child: CommunityCustomListItem(
                currPlanIndex: index,
              ),
            );
          },
        );
      },
    );
  }
}