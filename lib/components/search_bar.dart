/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2020 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:plannit_frontend/components/search_delegate_implementation.dart';

// import classes
import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/explore_specified_cat.dart';
import 'package:plannit_frontend/components/search_explore_delegate.dart';

/// Search bar for Explore
class ExploreMainSearchBar extends StatelessWidget {
  final List<String> list = List.generate(10, (index) => "Text $index");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, bottom: 20, left: 10, right: 10),
      child: RaisedButton(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        onPressed: () async {
          // showSearch(
          //   context: context,
          //   delegate: SearchExploreDelegate(),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchDelegateImplementation(
                needAddToPlan: false,
              ),
            ),
          );

          // print("DEBUG in search bar: " + query.toString());

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ExploreSpecifiedCatWidget(
          //       query: query.toString(),
          //       needAddToPlan: false,
          //       inSaved: false,
          //       inPlanEditor: false,
          //     ),
          //   ),
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SearchView(
          //       needAddToPlan: false,
          //       inSaved: false,
          //       inPlanEditor: false,
          //     ),
          //   ),
          // );
        },
        color: Colors.white,
        textColor: Colors.black12,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
              ),
              Text(
                "Tìm nơi khám phá",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ExploreInnerSearchBar extends StatelessWidget {
//   final bool needAddToPlan;
//   final bool inSaved;
//   final bool inPlanEditor;
//   final chosenItems;
//   final List<String> list = List.generate(10, (index) => "Text $index");
//
//   ExploreInnerSearchBar({
//     @required this.needAddToPlan,
//     @required this.inSaved,
//     @required this.inPlanEditor,
//     this.chosenItems,
//   })  : assert(needAddToPlan != null),
//         assert(inPlanEditor != null),
//         assert(inSaved != null);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 50, bottom: 10, left: 10, right: 10),
//       child: RaisedButton(
//         elevation: 10,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         onPressed: () async {
//           //showSearch(context: context, delegate: Search(list));
//           chosenItems.addAll(await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => SearchView(
//                 needAddToPlan: needAddToPlan,
//                 inPlanEditor: inPlanEditor,
//                 inSaved: inSaved,
//               ),
//             ),
//           ));
//         },
//         color: Colors.white,
//         textColor: Colors.black12,
//         child: Container(
//           padding: EdgeInsets.all(10),
//           child: Row(
//             children: [
//               IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_ios,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {
//                   if (needAddToPlan)
//                     Navigator.pop(context, chosenItems);
//                   else
//                     Navigator.pop(context);
//                 },
//               ),
//               // GestureDetector(
//               //   onTap: () {
//               //     if (needAddToPlan) Navigator.pop(context, chosenItems);
//               //     else Navigator.pop(context);
//               //   },
//               //   child: Icon(
//               //     Icons.arrow_back_ios,
//               //     color: Colors.black,
//               //   ),
//               // ),
//               Icon(
//                 Icons.search,
//                 color: Colors.black,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 15),
//               ),
//               Text("Tìm chỗ khám phá", style: TextStyle(fontSize: 18)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/// Search bar to look for user's friends
// class FriendSearchBar extends StatelessWidget {
//   final List<String> list = List.generate(10, (index) => "Text $index");
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
//       child: RaisedButton(
//         elevation: 10,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => SearchView(
//                 inSaved: false,
//                 inPlanEditor: false,
//                 needAddToPlan: false,
//               ),
//             ),
//           );
//         },
//         color: Colors.white,
//         textColor: Colors.black12,
//         child: Container(
//           padding: EdgeInsets.all(10),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.search,
//                 color: Colors.black,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 15),
//               ),
//               Text("Tìm bạn mà chơi", style: TextStyle(fontSize: 18)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
