import 'dart:developer';

/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// import classes
import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/explore_individual_item.dart';
import 'package:plannit_frontend/models/my_plan_data.dart';

/// DateCard for NewPlan menu
/// (w/o "Heart" button)
class DateCard extends StatefulWidget {
  final String date;
  final bool inSaved;
  final currCatIndex;

  DateCard({
    @required this.date,
    @required this.inSaved,
    this.currCatIndex,
  })  : assert(inSaved != null),
        assert(date != null);

  _DateCardState createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  // Get the current user ID
  // for like Explore item workflow
  final uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPlanData>(
      builder: (context, myCurrPlan, _) {
        DocumentReference planRef = FirebaseFirestore.instance
            .collection('plans')
            .doc(myCurrPlan.planId);

        return Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    widget.date,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                widget.inSaved
                    ? Row(
                        children: [
                          Text(myCurrPlan
                              .getLikeNum(widget.currCatIndex, widget.date)
                              .toString()),
                          GestureDetector(
                            onTap: () {
                              if (myCurrPlan.likedItem(
                                  widget.currCatIndex, uid, widget.date)) {
                                // unlike the item
                                // then update planContent in the plan
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
                                      updatedContent[widget.currCatIndex]
                                              ['exploreIdList'][widget.date]
                                          .remove(uid);

                                      // Perform an update on the document
                                      transaction.update(planRef,
                                          {'contents': updatedContent});
                                    })
                                    .then((value) =>
                                        print("Plan unlike to $value"))
                                    .catchError((error) => print(
                                        "Failed to unlike item in plan: $error"));
                              } else {
                                // like the item
                                // then update planContent in the plan
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
                                      updatedContent[widget.currCatIndex]
                                              ['exploreIdList'][widget.date]
                                          .add(uid);

                                      // Perform an update on the document
                                      transaction.update(planRef,
                                          {'contents': updatedContent});
                                    })
                                    .then(
                                        (value) => print("Plan like to $value"))
                                    .catchError((error) => print(
                                        "Failed to like item in plan: $error"));
                              }
                            },
                            child: myCurrPlan.likedItem(
                                    widget.currCatIndex, uid, widget.date)
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                          ),
                        ],
                      )
                    : Padding(padding: EdgeInsets.all(20)),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Card for Explore items
// Card for individual Explore item
class ExploreItemCard extends StatelessWidget {
  final exploreItem; // the ExploreData itself
  final bool needAddToPlan; // check if need to have add-to-plan button
  final currCatIndex; // index of current category from the plan editor
  final chosenExplore; // stuffs chosen in a single specified-cat session
  final bool
      needSmallCard; // check if need small pic or big pic for explore item card
  final bool inPlanEditor;
  final bool
      needVoteAndDel; // check if in specified cat-explore or in plan editor
  final bool inSaved; // check if in new-plan editor or Saved's editors

  ExploreItemCard({
    @required this.exploreItem,
    @required this.needAddToPlan,
    @required this.needSmallCard,
    @required this.inPlanEditor,
    @required this.needVoteAndDel,
    @required this.inSaved,
    this.currCatIndex,
    this.chosenExplore,
  })  : assert(exploreItem != null),
        assert(needAddToPlan != null),
        assert(needSmallCard != null),
        assert(inPlanEditor != null),
        assert(inSaved != null),
        assert(needVoteAndDel != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualExploreItem(
              exploreItem: exploreItem,
              chosenExplore: chosenExplore,
              currCatIndex: currCatIndex,
              needAddToPlan: needAddToPlan,
            ),
          ),
        );
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            needSmallCard
                ? ExploreItemPicSmall(
                    busPic: exploreItem.business_pic[0],
                  )
                : ExploreItemPicBig(
                    busPic: exploreItem.business_pic[0],
                  ),
            Container(
              padding: EdgeInsets.all(10),
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 10,
                        child: ExploreName(
                          name: exploreItem.name,
                          //titleTheme: titleTheme,
                        ),
                      ),
                      // Flexible(
                      //   flex: 2,
                      //   child: BusinessDistance(
                      //     distance: "0.3km",
                      //   ),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.5),
                  ),
                  ExploreRatingAndReview(
                    ratingCount: exploreItem.rating,
                    reviewCount: exploreItem.review_count,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.5),
                  ),
                  // BusinessPrice(price: business.price_range),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 2.5),
                  // ),
                  ExploreAddress(address: exploreItem.address),
                  Padding(
                    padding: EdgeInsets.only(top: 2.5),
                  ),
                  ExploreDistrictAndCity(
                    district: exploreItem.district,
                    city: exploreItem.city,
                  ),
                  // BusinessAttributes(attributes: business.attributes),
                  Padding(
                    padding: EdgeInsets.only(top: 2.5),
                  ),
                  ExploreHours(openHours: exploreItem.open_hours),
                  !needVoteAndDel
                      ? Padding(
                          padding: EdgeInsets.only(top: 2.5),
                        )
                      : ExploreCardLowerUtil(
                          inSaved: inSaved,
                          currCatIndex: currCatIndex,
                          exploreItemId: exploreItem.business_id,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Rep picture for Explore item
// small sized for main Explore menu
// in horizontal listview
class ExploreItemPicSmall extends StatelessWidget {
  final busPic;

  ExploreItemPicSmall({this.busPic});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
          ),
          child: busPic == ""
              ? Image(image: AssetImage('assets/images/ho_guom.jpg'))
              : Image.network(
                  busPic,
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }
}

// Rep picture for Explore item
// big sized for in editors
// and category specified listview
class ExploreItemPicBig extends StatelessWidget {
  final busPic;

  ExploreItemPicBig({this.busPic});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
          ),
          child: busPic == ""
              ? Image(image: AssetImage('assets/images/ho_guom.jpg'))
              : Image.network(
                  busPic,
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }
}

class ExploreHours extends StatelessWidget {
  final String openHours;

  ExploreHours({this.openHours});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Giờ mở",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
        ),
        Text(openHours),
      ],
    );
  }
}

class ExploreAttributes extends StatelessWidget {
  final List attributes;

  ExploreAttributes({this.attributes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: attributes.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Icon(
                Icons.check,
                color: Colors.green,
                size: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
              ),
              Text(attributes[index]),
              Padding(
                padding: EdgeInsets.only(left: 5),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ExplorePrice extends StatelessWidget {
  final price;

  ExplorePrice({this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(price),
    );
  }
}

class ExploreName extends StatelessWidget {
  final String name;
  final titleTheme;

  ExploreName({this.name, this.titleTheme});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: titleTheme,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    );
  }
}

class ExploreDistance extends StatelessWidget {
  final distance;

  const ExploreDistance({this.distance});

  @override
  Widget build(BuildContext context) {
    return Text(
      distance,
      style: TextStyle(
        color: Colors.black45,
      ),
    );
  }
}

class ExploreAddress extends StatelessWidget {
  final String address;

  ExploreAddress({this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        address,
        style: TextStyle(color: Colors.black45),
        overflow: TextOverflow.clip,
        maxLines: 1,
      ),
    );
  }
}

class ExploreDistrictAndCity extends StatelessWidget {
  final String district;
  final String city;

  ExploreDistrictAndCity({
    this.district,
    this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "$district, $city",
        style: TextStyle(color: Colors.black45),
        overflow: TextOverflow.clip,
        maxLines: 1,
      ),
    );
  }
}

class ExploreRatingAndReview extends StatelessWidget {
  final ratingCount;
  final reviewCount;

  ExploreRatingAndReview({
    this.ratingCount,
    this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("$ratingCount/5 với $reviewCount đánh giá"),
    );
  }
}

// Utilities for each Explore card
// i.e: del card, like card(for collab)
// needed ONLY IN editors view (NewPlan/Saved)
class ExploreCardLowerUtil extends StatelessWidget {
  final bool inSaved;
  final currCatIndex;
  final exploreItemId;

  ExploreCardLowerUtil({
    @required this.inSaved,
    @required this.currCatIndex,
    @required this.exploreItemId,
  })  : assert(inSaved != null),
        assert(currCatIndex != null),
        assert(exploreItemId != null);

  @override
  Widget build(BuildContext context) {
    return inSaved
        ? Consumer<MyPlanData>(
            builder: (context, plan, _) {
              return Row(
                children: [
                  // Like count for this card
                  Text(
                    plan.getLikeNum(currCatIndex, exploreItemId).toString(),
                  ),

                  // Like card button
                  LikeCardInCatButton(
                    currCatIndex: currCatIndex,
                    exploreItemId: exploreItemId,
                  ),

                  // Card delete button
                  DelCardFromCatButton(
                    inSaved: inSaved,
                    currCatIndex: currCatIndex,
                    exploreItemId: exploreItemId,
                  ),
                ],
              );
            },
          )
        : Row(
            children: [
              // Card delete button ONLY
              DelCardFromCatButton(
                inSaved: inSaved,
                currCatIndex: currCatIndex,
                exploreItemId: exploreItemId,
              ),
            ],
          );
  }
}

// Like card button
// like & unlike using real-time transactions to Firestore
class LikeCardInCatButton extends StatefulWidget {
  final uid = FirebaseAuth.instance.currentUser.uid;
  final currCatIndex;
  final exploreItemId;

  LikeCardInCatButton({
    @required this.currCatIndex,
    @required this.exploreItemId,
  })  : assert(currCatIndex != null),
        assert(exploreItemId != null);

  _LikeCardInCatButtonState createState() => _LikeCardInCatButtonState();
}

class _LikeCardInCatButtonState extends State<LikeCardInCatButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyPlanData>(
      builder: (context, plan, _) {
        DocumentReference planRef =
            FirebaseFirestore.instance.collection('plans').doc(plan.planId);

        return IconButton(
          onPressed: () {
            // add to list of likers
            if (plan.likedItem(
                widget.currCatIndex, widget.uid, widget.exploreItemId)) {
              // then update planContent in the plan
              return FirebaseFirestore.instance
                  .runTransaction((transaction) async {
                    // Get the document
                    DocumentSnapshot snapshot = await transaction.get(planRef);

                    if (!snapshot.exists) {
                      throw Exception("Plan does not exist!");
                    }

                    List updatedContent = snapshot.data()['contents'];
                    updatedContent[widget.currCatIndex]['exploreIdList']
                            [widget.exploreItemId]
                        .remove(widget.uid);

                    // Perform an update on the document
                    transaction.update(planRef, {'contents': updatedContent});
                  })
                  .then((value) => print("Plan unlike to $value"))
                  .catchError((error) =>
                      print("Failed to unlike item in plan: $error"));
            } else {
              // then update planContent in the plan
              return FirebaseFirestore.instance
                  .runTransaction((transaction) async {
                    // Get the document
                    DocumentSnapshot snapshot = await transaction.get(planRef);

                    if (!snapshot.exists) {
                      throw Exception("Plan does not exist!");
                    }

                    List updatedContent = snapshot.data()['contents'];
                    updatedContent[widget.currCatIndex]['exploreIdList']
                            [widget.exploreItemId]
                        .add(widget.uid);

                    // Perform an update on the document
                    transaction.update(planRef, {'contents': updatedContent});
                  })
                  .then((value) => print("Plan like to $value"))
                  .catchError(
                      (error) => print("Failed to like item in plan: $error"));
            }
          },
          icon: plan.likedItem(
                  widget.currCatIndex, widget.uid, widget.exploreItemId)
              ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
        );
      },
    );
  }
}

// Delete card button
class DelCardFromCatButton extends StatelessWidget {
  final bool inSaved;
  final currCatIndex;
  final exploreItemId;

  DelCardFromCatButton({
    @required this.inSaved,
    @required this.currCatIndex,
    @required this.exploreItemId,
  })  : assert(inSaved != null),
        assert(currCatIndex != null),
        assert(exploreItemId != null);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPlanData>(
      builder: (context, plan, _) {
        return IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {
            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Xóa thẻ"),
                  content: Text("Bạn có chắc muốn xóa thẻ này?"),
                  actions: [
                    FlatButton(
                      child: Text(
                        "Xóa",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        // 2 different situations for deleting certain card
                        // del from a real-time stream transaction
                        // vs.
                        // del from Consumer<MyPlanData>
                        if (inSaved) {
                          //del from stream
                          DocumentReference planRef = FirebaseFirestore.instance
                              .collection('plans')
                              .doc(plan.planId);

                          FirebaseFirestore.instance
                              .runTransaction((transaction) async {
                                // Get the document
                                DocumentSnapshot snapshot =
                                    await transaction.get(planRef);

                                if (!snapshot.exists) {
                                  throw Exception("Plan does not exist!");
                                }

                                // remove the Explore item from the map
                                // using its id
                                List updatedContent =
                                    snapshot.data()['contents'];
                                updatedContent[currCatIndex]['exploreIdList']
                                    .remove(exploreItemId);

                                // Perform an update on the document
                                transaction.update(
                                    planRef, {'contents': updatedContent});
                              })
                              .then((value) =>
                                  print("Deleted card $value from plan"))
                              .catchError((error) => print(
                                  "Failed to delete card from plan: $error"));
                        } else {
                          plan.delChosenExplore(currCatIndex, exploreItemId);
                        }

                        // Pop-out from dialog
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Hủy",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        // Pop-out from dialog
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
