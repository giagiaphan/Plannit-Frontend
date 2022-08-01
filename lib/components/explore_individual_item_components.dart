import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// This code belongs to Plannit LLC.
/// Copyright © 2020 by Plannit LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plannit_frontend/components/network_endpoints.dart';
import 'package:plannit_frontend/models/review_data.dart';
import 'package:plannit_frontend/models/user_data.dart';
import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/explore_review_item.dart';
import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/take_pic_screen.dart';

/// Components for individual Explore item
/// ----------------------------------------------------------------------------
/// 2 types of bottom app bars: w/ add-to-plan button and w/o
// Bottom app bar type 1 for individual explore item
class ItemStatBottomAppBar extends StatelessWidget {
  final smallFontSize;
  final currCatIndex;
  final currExploreId;
  final chosenOnes;
  final rating;
  final review_count;

  ItemStatBottomAppBar({
    this.smallFontSize,
    this.currCatIndex,
    this.currExploreId,
    this.chosenOnes,
    this.review_count,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              "$rating/5.0\nvới $review_count đánh giá",
              style: TextStyle(fontSize: smallFontSize),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ExploreReviewWidget(businessId: currExploreId),
                ),
              );
            },
            child: Text(
              "Đánh giá chúng tôi",
              style: TextStyle(
                color: Colors.white,
                fontSize: smallFontSize,
              ),
            ),
            color: Colors.green[700],
          ),
        ],
      ),
    );
  }
}

class AddToPlanBottomAppBar extends StatefulWidget {
  final smallFontSize;
  final currCatIndex;
  final currExploreId;
  final chosenItems;
  final rating;
  final reviewCount;

  AddToPlanBottomAppBar({
    this.smallFontSize,
    this.currCatIndex,
    this.currExploreId,
    @required this.chosenItems,
    this.rating,
    this.reviewCount,
  }) : assert(chosenItems != null);

  _AddToPlanBottomAppBar createState() => _AddToPlanBottomAppBar();
}
// Bottom app bar type 2 for individual explore item
class _AddToPlanBottomAppBar extends State<AddToPlanBottomAppBar> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              "${widget.rating}/5.0\nvới ${widget.reviewCount} đánh giá",
              style: TextStyle(fontSize: widget.smallFontSize),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              setState(() {
                widget.chosenItems[widget.currExploreId] = [];
              });

              Navigator.of(context).pop();
            },
            child: widget.chosenItems.containsKey(widget.currExploreId)
                ? Text(
              "Đã thêm vào kế hoạch",
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.smallFontSize,
              ),
            )
                : Text(
              "Thêm vào kế hoạch",
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.smallFontSize,
              ),
            ),
            color: widget.chosenItems.containsKey(widget.currExploreId)
                ? Colors.green : Colors.red[700],
          ),
        ],
      ),
    );
  }
}

/// From here, all components represented top->bottom
/// according to positions in the app

// Pictures window section of the Explore item
class BusinessPicWindow extends StatelessWidget {
  final double picWid = 440;
  final busPic;

  BusinessPicWindow({this.busPic});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Container(
        alignment: Alignment.center,
        child: Image.network(
          busPic,
          width: picWid,
          fit: BoxFit.fill,
          //fontFamily: 'Salsa',
        ),
      ),
    );
  }
}

// General information section about the Explore item
class BusinessGeneralInfo extends StatelessWidget {
  final smallFontSize;
  final bigFontSize;
  final business;

  BusinessGeneralInfo({
    this.smallFontSize,
    this.bigFontSize,
    this.business,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                business.name,
                style: TextStyle(
                  fontSize: bigFontSize,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.store),
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                  ),
                  Flexible(
                    child: Text(
                      "${business.address}, ${business.district}, ${business
                          .city}",
                      style: TextStyle(
                        fontSize: smallFontSize,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Row(
                children: [
                  Icon(Icons.stars),
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                  ),
                  Text(
                    business.rating.toString() + "/5.0",
                    style: TextStyle(
                      fontSize: smallFontSize,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Row(
                children: [
                  Icon(Icons.rate_review),
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                  ),
                  Text(
                    "${business.review_count} lượt đánh giá",
                    style: TextStyle(
                      fontSize: smallFontSize,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.access_time),
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                  ),
                  Text(
                    "Giờ mở",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                  ),
                  Text(
                    business.open_hours.toString(),
                    style: TextStyle(
                      fontSize: smallFontSize,
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     Icon(Icons.monetization_on),
              //     Padding(
              //       padding: EdgeInsets.only(right: 5.0),
              //     ),
              //     Text(
              //       price_range,
              //       style: TextStyle(
              //         fontSize: smallFontSize,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Center(
        //       child: Column(
        //         children: [
        //           Text(business.review_count.toString()),
        //           Text("Đánh giá"),
        //         ],
        //       ),
        //     ),
        //     Center(
        //       child: Column(
        //         children: [
        //           Text("0"),
        //           Text("Check-ins"),
        //         ],
        //       ),
        //     ),
        //     Center(
        //       child: Column(
        //         children: [
        //           Text("12"),
        //           Text("Được yêu thích"),
        //         ],
        //       ),
        //     ),
        //     Center(
        //       child: Column(
        //         children: [
        //           Text("12"),
        //           Text("Ảnh"),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // Column(
        //   children: [
        //     Container(
        //       padding: EdgeInsets.only(
        //         right: 20,
        //         left: 20,
        //         top: 10,
        //         bottom: 10,
        //       ),
        //       child: Divider(
        //         color: Colors.black,
        //         height: 0,
        //       ),
        //     ),
        //   ],
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {},
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.phone),
                    Text("Gọi chúng tôi!"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.map),
                    Text("Bản đồ"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.web),
                    Text("Trang web"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.restaurant_menu),
                    Text("Thực đơn"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Section divider (to make things look niceeee)
class SectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Divider(
              color: Colors.black12,
              thickness: 10,
            ),
          ),
        ),
      ],
    );
  }
}

// Review box section where user rates the Explore item
class ReviewBox extends StatelessWidget {
  final businessName;
  final businessId;

  ReviewBox(this.businessId, this.businessName);

  Widget ratingBar(BuildContext context) {
    return RatingBar.builder(
      initialRating: 0,
      itemCount: 5,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
        }
        return null;
      },
      onRatingUpdate: (rating) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ExploreReviewWidget(
                  businessId: businessId,
                  businessName: businessName,
                  rating: rating,
                ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Đánh giá chúng tôi:"),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          ratingBar(context),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TakePictureWidget(),
                ),
              );
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_enhance),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                  ),
                  Text("Thêm ảnh"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "About us" information of the Explore item
class AboutUs extends StatelessWidget {
  final fontSize;

  AboutUs({this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Về chúng tôi",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("This restaurant has been here for 10 years. etc"),
        ],
      ),
    );
  }
}

/// Explore item Review components
// Start of section to look at Review from users
class ReviewFromCommunity extends StatefulWidget {
  final businessId;

  ReviewFromCommunity({this.businessId});

  _ReviewFromCommunityState createState() => _ReviewFromCommunityState();
}

class _ReviewFromCommunityState extends State<ReviewFromCommunity> {
  List<ReviewData> reviewList;

  Future<void> getReviews() async {
    var reviewListFuture = await fetchReviewJson(widget.businessId);
    print("get reviews");
    setState(() {
      reviewList.addAll(reviewListFuture);
    });
  }

  initState() {
    super.initState();
    reviewList = List();
    getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Đánh giá từ cộng đồng",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: reviewList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 350,
                    child: BusinessReviewCard(reviewList[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Review card for each user's ReviewData
class BusinessReviewCard extends StatelessWidget {
  final review;

  BusinessReviewCard(this.review);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;

    DocumentReference reviewer =
    FirebaseFirestore.instance.collection('users').doc(review.reviewer_id);

    DocumentReference reviewRef =
    FirebaseFirestore.instance.collection('reviews').doc(review.review_id);

    return FutureBuilder(
      future: reviewer.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData user =
          UserData.fromJson(snapshot.data.data(), review.reviewer_id);

          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      UserAvatar(),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Expanded(
                        child: UserName(user.username),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserRating(review.rating),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      UserReviewDateTime(review.review_at),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  Expanded(
                    child: Text(
                      review.text,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: review.pictures.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 5.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.network(review.pictures[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, return a loading spinner
        return CircularProgressIndicator();
      },
    );
  }
}

// reviewer's avatar
class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: SvgPicture.asset('assets/icons/OFFICIAL_LOGO.svg'),
    );
  }
}

// reviewer's username
class UserName extends StatelessWidget {
  final reviewer;

  UserName(this.reviewer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 25,
      child: Text(
        reviewer,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

// reviewer's statistics row
class UserStatRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          UserStatCheckInCount(),
          Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          UserStatFriendCount(),
          Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          UserStatReviewCount(),
        ],
      ),
    );
  }
}

// reviewer's review-count stat
class UserStatReviewCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.stars),
        Padding(
          padding: EdgeInsets.only(left: 5),
        ),
        Text("1"),
      ],
    );
  }
}

// reviewer's check-in-count stat
class UserStatCheckInCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.image),
        Padding(
          padding: EdgeInsets.only(left: 5),
        ),
        Text("20"),
      ],
    );
  }
}

// reviewer's friend-count stat
class UserStatFriendCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.people_outline),
        Padding(
          padding: EdgeInsets.only(left: 5),
        ),
        Text("20"),
      ],
    );
  }
}

// review's star rating
class UserRating extends StatelessWidget {
  final rating;

  UserRating(this.rating);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 24,
      initialRating: rating * 1.0,
      itemCount: 5,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
        }
        return null;
      },
    );
  }
}

// review made at...
class UserReviewDateTime extends StatelessWidget {
  final review_at;

  UserReviewDateTime(this.review_at);

  @override
  Widget build(BuildContext context) {
    return Text(
      "đánh giá từ $review_at",
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }
}
