// import 'package:flutter/material.dart';
//
// import 'package:plannit_frontend/components/my_saved_components.dart';
// import 'package:plannit_frontend/models/my_plan_data.dart';
// import 'package:plannit_frontend/models/community_saved_plans.dart';
//
//
// class FavouritedBusinesses extends StatelessWidget {
//   final planData;
//
//   FavouritedBusinesses({Key key, this.planData}) : super(key: key);
//
//   PlanData modelPlan = new PlanData(
//     planName: "My trip to Paris",
//     budget: 2020202,
//     planCreator: "Kyle Ngo",
//   );
//
//   List<PlanData> planList = CommunitySavedPlans.savedList;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(8.0),
//       itemExtent: 106.0,
//       itemCount: planList.length,
//       itemBuilder: (context, index) {
//         return CustomListItem(
//           planCreator: planList[index].planCreator,
//           viewCount: planList[index].budget,
//           thumbnail: Container(
//             decoration: const BoxDecoration(color: Colors.yellow),
//           ),
//           title: planList[index].planName,
//         );
//       },
//     );
//   }
// }