/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import classes
import 'package:plannit_frontend/models/my_plan_data.dart';
import 'package:plannit_frontend/screens/inner_layers/new_plan_inner_layers/add_collaborator.dart';
import 'package:plannit_frontend/screens/inner_layers/new_plan_inner_layers/categories.dart';
import 'package:plannit_frontend/models/category_specific_data.dart';
import 'explore_item_card_components.dart';
import 'network_endpoints.dart';
import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/explore_specified_cat.dart';

/// Components for all plan editors (New Plan and Saved My atm)
/// ----------------------------------------------------------------------------

// Plan name input & Collab adder
class UpperUtilBar extends StatelessWidget {
  final bool inSaved;

  UpperUtilBar({@required this.inSaved}) : assert(inSaved != null);

  final snackBar = SnackBar(
    content: Text('Đã tạo kế hoạch của bạn thành công!'),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPlanData>(
      builder: (context, myCurrPlan, _) {
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
                  onPressed: () async {
                    if (!inSaved) {
                      if (myCurrPlan.planContents.length > 0) {
                        CollectionReference plans =
                            FirebaseFirestore.instance.collection('plans');

                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            print("Here");
                            return AlertDialog(
                              title: Text("Lưu kế hoạch"),
                              content: Text("Bạn có muốn lưu kế hoạch này?"),
                              actions: [
                                FlatButton(
                                  child: Text("Lưu"),
                                  onPressed: () {
                                    plans.add(myCurrPlan.toJson()).then(
                                        (value) {
                                      // // show snackbar informing user that plan added
                                      // Scaffold.of(context)
                                      //     .showSnackBar(snackBar);
                                      // Second, send out invitations to all collaborator

                                      addCollaborators(myCurrPlan.inviteesToString(),
                                          myCurrPlan.planName);
                                      Navigator.of(context).pop();
                                    }).catchError((error) =>
                                        print("Failed to create plan: $error"));
                                  },
                                ),
                                FlatButton(
                                  child: Text("Xóa kế hoạch"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                      Navigator.pop(context);
                    } else
                      Navigator.pop(context);
                  },
                ),

                // Plan name input field
                Container(
                  width: 220,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(labelText: myCurrPlan.planName),
                    onChanged: (val) {
                      myCurrPlan.planName = val;
                    },
                  ),
                ),

                // Modify collaborators
                GestureDetector(
                  onTap: () async {
                    //myCurrPlan.initInvitees(0);
                    List invitees = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCollaborator(
                          currInvitees: myCurrPlan.getInvitees,
                        ),
                      ),
                    );

                    if(invitees.length > 0) {
                      if(!inSaved) myCurrPlan.addInvitees(invitees);
                      else {
                        DocumentReference planRef = plans.doc(myCurrPlan.planId);

                        // add to the array contents
                        return FirebaseFirestore.instance
                            .runTransaction((transaction) async {
                          // Get the document
                          DocumentSnapshot snapshot =
                          await transaction.get(planRef);

                          if (!snapshot.exists) {
                            throw Exception("Plan does not exist!");
                          }

                          List updatedCollab = invitees;

                          // Perform an update on the document
                          transaction
                              .update(planRef, {'collaborators': updatedCollab});
                        })
                            .then((value) => print("Plan added new collab $value"))
                            .catchError((error) =>
                            print("Failed to add new collab in plan: $error"));
                      }
                    }
                  },
                  child: Icon(Icons.person_add),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FabButton extends StatelessWidget {
  final bool initPlan;

  FabButton({@required this.initPlan}) : assert(initPlan != null);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPlanData>(
      builder: (context, myPlan, _) {
        DocumentReference planRef = plans.doc(myPlan.planId);

        return FloatingActionButton.extended(
          //backgroundColor: Color(0xffffcbc2),
          onPressed: () async {
            final catChosen = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => Categories()));

            // If chosen a cat back in the category list
            if (catChosen != null) {
              // If not in Saved's editors
              // aka currently in NewPlan's editor
              // add straight to the plan obj's Consumer
              if (initPlan) myPlan.add(catChosen);
              // Else, add the new Category to the real-time stream
              // thru a transaction
              else {
                // add to the array contents
                return FirebaseFirestore.instance
                    .runTransaction((transaction) async {
                  // Get the document
                  DocumentSnapshot snapshot =
                  await transaction.get(planRef);

                  if (!snapshot.exists) {
                    throw Exception("Plan does not exist!");
                  }

                  List updatedContent = snapshot.data()['contents'];
                  updatedContent.add(catChosen.toJson());

                  // Perform an update on the document
                  transaction
                      .update(planRef, {'contents': updatedContent});
                })
                    .then((value) => print("Plan added new cat $value"))
                    .catchError((error) =>
                    print("Failed to add new cat in plan: $error"));
              }
            }
          },
          label: Text("Thêm thể loại"),
          icon: Icon(Icons.add),
        );
      },
    );
  }
}

// FAB button
// class SpeedDialFAB extends StatelessWidget {
//   CollectionReference plans = FirebaseFirestore.instance.collection('plans');
//   final bool inSaved;
//
//   SpeedDialFAB({@required this.inSaved}) : assert(inSaved != null);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MyPlanData>(
//       builder: (context, myCurrPlan, _) {
//         // Make reference to the plan in Firestore
//         DocumentReference planRef = plans.doc(myCurrPlan.planId);
//
//         return SpeedDial(
//           marginRight: 18,
//           marginBottom: 20,
//           animatedIcon: AnimatedIcons.menu_close,
//           animatedIconTheme: IconThemeData(size: 22.0),
//           closeManually: false,
//           curve: Curves.bounceIn,
//           overlayColor: Colors.black,
//           overlayOpacity: 0.5,
//           tooltip: 'Speed Dial',
//           heroTag: 'speed-dial-hero-tag',
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           elevation: 8.0,
//           shape: CircleBorder(),
//           children: [
//             SpeedDialChild(
//               child: Icon(Icons.save_alt),
//               backgroundColor: Colors.purple,
//               label: 'Lưu kế hoạch',
//               labelStyle: TextStyle(fontSize: 18.0),
//               onTap: () {
//                 if (!inSaved) {
//                   // First, save the plan to Firestore
//                   // for the first time ever
//                   plans
//                       .add(myCurrPlan.toJson())
//                       .then((value) => print("Plan Added"))
//                       .catchError(
//                           (error) => print("Failed to create plan: $error"));
//
//                   // Second, send out invitations to all collaborators
//                   addCollaborators(myCurrPlan.inviteesToString(), myCurrPlan.planName);
//                 }
//
//                 // Build a AlertDialog
//                 // alerting user that plan has been saved
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text("Lưu kế hoạch"),
//                       content: Text(
//                           "Chúc mừng! Kế hoạch của bạn đã được lưu thành công!"),
//                       actions: [
//                         FlatButton(
//                           child: Text("OK"),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//             SpeedDialChild(
//               child: Icon(Icons.add),
//               backgroundColor: Colors.blue,
//               label: 'Thêm thể loại',
//               labelStyle: TextStyle(fontSize: 18.0),
//               onTap: () async {
//                 final catChosen = await Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Categories()));
//
//                 // If chosen a cat back in the category list
//                 if (catChosen != null) {
//                   // If not in Saved's editors
//                   // aka currently in NewPlan's editor
//                   // add straight to the plan obj's Consumer
//                   if (!inSaved)
//                     myCurrPlan.add(catChosen);
//
//                   // Else, add the new Category to the real-time stream
//                   // thru a transaction
//                   else {
//                     // add to the array contents
//                     return FirebaseFirestore.instance
//                         .runTransaction((transaction) async {
//                           // Get the document
//                           DocumentSnapshot snapshot =
//                               await transaction.get(planRef);
//
//                           if (!snapshot.exists) {
//                             throw Exception("Plan does not exist!");
//                           }
//
//                           List updatedContent = snapshot.data()['contents'];
//                           updatedContent.add(catChosen.toJson());
//
//                           // Perform an update on the document
//                           transaction
//                               .update(planRef, {'contents': updatedContent});
//                         })
//                         .then((value) => print("Plan added new cat $value"))
//                         .catchError((error) =>
//                             print("Failed to add new cat in plan: $error"));
//                   }
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// Utility bar for each category
class CategoryUtilRow extends StatelessWidget {
  final currCatIndex;
  final titleTheme;
  final bool inSaved;
  final bool inPlanEditor;

  CategoryUtilRow({
    this.currCatIndex,
    this.titleTheme,
    @required this.inSaved,
    @required this.inPlanEditor,
  })  : assert(inSaved != null),
        assert(inPlanEditor != null);

  Map<String, dynamic> calculateDaysInterval(
      DateTime startDate, DateTime endDate) {
    List<String> days = [];

    final daysToGenerate = endDate.difference(startDate).inDays + 1;
    days = List.generate(
        daysToGenerate,
        (i) => DateFormat('dd-MM-yyyy')
            .format(
                DateTime(startDate.year, startDate.month, startDate.day + (i)))
            .toString());

    Map<String, dynamic> dateMap = new Map();
    for (var day in days) {
      dateMap[day] = [];
    }

    return dateMap;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPlanData>(
      builder: (context, myCurrPlan, _) {
        DocumentReference planRef = FirebaseFirestore.instance
            .collection('plans')
            .doc(myCurrPlan.planId);

        return Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    myCurrPlan.planContents[currCatIndex].category,
                    style: titleTheme,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  GestureDetector(
                    onTap: () {
                      myCurrPlan.modifyLock(currCatIndex);
                    },
                    child: myCurrPlan.planContents[currCatIndex].lockStatus
                        ? Icon(
                            Icons.lock_outline,
                            color: Colors.green[900],
                          )
                        : Icon(
                            Icons.lock_open,
                            color: Colors.red[600],
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      primaryColor: Colors.purple,
                    ),
                    child: Builder(
                      builder: (context) => GestureDetector(
                        onTap: () async {
                          CategorySpecificData currCat =
                              myCurrPlan.planContents[currCatIndex];
                          String currCatName =
                              currCat.catMapping[currCat.category];

                          if (currCatName != "Create dates") {
                            Map<String, dynamic> chosenExplore = currCat.exploreIdList;

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExploreSpecifiedCatWidget(
                                  currCat: currCatName,
                                  query: currCatName,
                                  needAddToPlan: true,
                                  currCatIndex: currCatIndex,
                                  inSaved: inSaved,
                                  inPlanEditor: inPlanEditor,
                                  chosenExplore: chosenExplore,
                                ),
                              ),
                            );

                            // If chosen any item back in CatSpecified view
                            if (chosenExplore.length > 0) {
                              // If not in Saved's editors
                              // a.k.a currently in NewPlan's editor
                              // just add to Consumer's plan obj
                              if (!inSaved)
                                myCurrPlan.addChosenExplore(
                                    currCatIndex, chosenExplore);
                              // Else, add to real-time stream instead
                              else {
                                return FirebaseFirestore.instance
                                    .runTransaction((transaction) async {
                                      // Get the document
                                      DocumentSnapshot snapshot =
                                          await transaction.get(planRef);

                                      if (!snapshot.exists) {
                                        throw Exception("Plan does not exist!");
                                      }

                                      List updatedContent =
                                          snapshot.data()['contents'];
                                      updatedContent[currCatIndex]
                                              ['exploreIdList'] = chosenExplore;

                                      // Perform an update on the document
                                      transaction.update(planRef,
                                          {'contents': updatedContent});
                                    })
                                    .then((value) =>
                                        print("Plan added new items $value"))
                                    .catchError((error) => print(
                                        "Failed to add new items in plan: $error"));
                              }
                            }
                          } else {
                            DateTimeRange picked = await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year - 5),
                              lastDate: DateTime(DateTime.now().year + 5),
                              initialDateRange: DateTimeRange(
                                end: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day + 13),
                                start: DateTime.now(),
                              ),
                            );
                            Map<String, dynamic> days =
                                calculateDaysInterval(picked.start, picked.end);

                            // If chosen any date
                            if (days.length > 0)
                            // If in NewPlan's editor
                            // add to the Consumer's plan obj
                            if (!inSaved)
                              myCurrPlan.addChosenExplore(currCatIndex, days);
                            // Otherwise, add to the real-time stream
                            // thru a transaction
                            else {
                              return FirebaseFirestore.instance
                                  .runTransaction((transaction) async {
                                    // Get the document
                                    DocumentSnapshot snapshot =
                                        await transaction.get(planRef);

                                    if (!snapshot.exists) {
                                      throw Exception("Plan does not exist!");
                                    }

                                    List updatedContent =
                                        snapshot.data()['contents'];
                                    updatedContent[currCatIndex]
                                            ['exploreIdList']
                                        .addAll(days);

                                    // Perform an update on the document
                                    transaction.update(
                                        planRef, {'contents': updatedContent});
                                  })
                                  .then((value) =>
                                      print("Plan added new dates $value"))
                                  .catchError((error) => print(
                                      "Failed to add new dates in plan: $error"));
                            }
                          }
                        },
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  GestureDetector(
                    onTap: () {
                      Widget okButton = FlatButton(
                        child: Text(
                          "Xóa",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red,
                          ),
                        ),
                        onPressed: () {
                          // If in a Saved's plan editor
                          // del the category and its contents from stream
                          // thru a transaction
                          if (inSaved) {
                            //del from stream
                            FirebaseFirestore.instance
                                .runTransaction((transaction) async {
                                  // Get the document
                                  DocumentSnapshot snapshot =
                                      await transaction.get(planRef);

                                  if (!snapshot.exists) {
                                    throw Exception("Plan does not exist!");
                                  }

                                  List updatedContent =
                                      snapshot.data()['contents'];
                                  updatedContent.removeAt(currCatIndex);

                                  // Perform an update on the document
                                  transaction.update(
                                      planRef, {'contents': updatedContent});
                                })
                                .then((value) =>
                                    print("Deleted category $value from plan"))
                                .catchError((error) => print(
                                    "Failed to delete category from plan: $error"));
                          }
                          // Otherwise, in NewPlan's editor,
                          // del from the Consumer's plan obj
                          else {
                            myCurrPlan.remove(currCatIndex);
                          }

                          // Pop-out of the dialog
                          Navigator.of(context).pop();
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
                          // Pop-out of the dialog box
                          Navigator.of(context).pop();
                        },
                      );

                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Xóa thể loại"),
                        content: Text("Bạn có chắc muốn xóa thể loại này?"),
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
                    },
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.black,
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

// PageView for Explore cards
class BusinessBoxPageView extends StatefulWidget {
  final titleTheme;
  final catSpecificData;
  final currCatIndex;
  final bool needVoteAndDel;
  final bool inSaved;

  BusinessBoxPageView({
    this.titleTheme,
    this.catSpecificData,
    this.currCatIndex,
    @required this.needVoteAndDel,
    @required this.inSaved,
  })  : assert(inSaved != null),
        assert(needVoteAndDel != null);

  @override
  _BusinessBoxPageViewState createState() => _BusinessBoxPageViewState();
}

class _BusinessBoxPageViewState extends State<BusinessBoxPageView> {
  // double currPos = 0.0;
  // PageController pageController;
  // Map<String, dynamic> mapExploreItems;

  // Future<void> getExploreItems(String objectId) async {
  //   var exploreFuture = await fetchOneExplore(objectId);
  //   print('getOneMoreExploreItem');
  //   setState(() {
  //     mapExploreItems[objectId] = exploreFuture;
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   pageController = PageController();
  //   mapExploreItems = Map();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 366, // this determines how big the ExploreItemCard will be
          child: PageView.builder(
            physics: widget.catSpecificData.lockStatus
                ? NeverScrollableScrollPhysics()
                : AlwaysScrollableScrollPhysics(),
            itemCount: widget.catSpecificData.exploreIdList.length,
            onPageChanged: (pageNum) {
              // setState(() {
              //   currPos = pageNum * 1.0;
              // });
            },
            itemBuilder: (context, index) {
              if (widget.catSpecificData.category != "Ngày đi") {
                String currId =
                    widget.catSpecificData.exploreIdList.keys.elementAt(index);
                print("DEBUG in plan editor components: " + currId);

                return FutureBuilder(
                    future: fetchOneExplore(currId),
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (snapshot.hasData) {
                        return ExploreItemCard(
                          exploreItem: snapshot.data,
                          needAddToPlan: true,
                          needSmallCard: false,
                          inPlanEditor: true,
                          needVoteAndDel: widget.needVoteAndDel,
                          inSaved: widget.inSaved,
                          currCatIndex: widget.currCatIndex,
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return CircularProgressIndicator();
                    });
                // if(mapExploreItems.containsKey(currId)) {
                //   return ExploreItemCard(
                //     inSaved: false,
                //     inPlanEditor: true,
                //     inSpecifiedCat: false,
                //     exploreItem: mapExploreItems[currId],
                //     currCatIndex: widget.currCatIndex,
                //     needAddToPlan: true,
                //     needSmallCard: false,
                //   );
                // }
                // add to map and return it?? need to check due to async
                // getExploreItems(currId);
                // return ExploreItemCard(
                //   inSaved: false,
                //   inPlanEditor: true,
                //   inSpecifiedCat: false,
                //   exploreItem: mapExploreItems[currId],
                //   currCatIndex: widget.currCatIndex,
                //   needAddToPlan: true,
                //   needSmallCard: false,
                // );
              }
              return DateCard(
                date: widget.catSpecificData.exploreIdList.entries
                    .toList()[index]
                    .key,
                inSaved: widget.inSaved,
                currCatIndex: widget.currCatIndex,
              );
            },
          ),
        ),
      ],
    );
  }
}
