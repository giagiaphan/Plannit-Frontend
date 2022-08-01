import 'package:flutter/material.dart';
import 'package:plannit_frontend/models/community_plan_data.dart';
import 'package:plannit_frontend/models/community_saved_plans.dart';
import 'package:plannit_frontend/models/my_plan_data.dart';
import 'package:plannit_frontend/models/my_saved_plans.dart';
import 'package:provider/provider.dart';


class CommunityCustomListItem extends StatelessWidget {
  final currPlanIndex;

  CommunityCustomListItem({
    this.currPlanIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CommunitySavedPlans>(
      builder: (context, communitySavedPlans, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.yellow),
                ),
              ),
              Expanded(
                flex: 3,
                child: PlanDescription(
                  title: communitySavedPlans.plans[currPlanIndex].planName,
                  planCreator: communitySavedPlans.plans[currPlanIndex].planCreator,
                  viewCount: communitySavedPlans.plans[currPlanIndex].budget,
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever),
                    onPressed: () {
                      communitySavedPlans.remove(currPlanIndex);
                    },
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

class PlanDescription extends StatelessWidget {
  const PlanDescription({
    Key key,
    this.title,
    this.planCreator,
    this.viewCount,
  }) : super(key: key);

  final String title;
  final String planCreator;
  final int viewCount;

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
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$viewCount views',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}
