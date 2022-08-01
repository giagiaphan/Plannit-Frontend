import 'package:firebase_auth/firebase_auth.dart';
/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

//import libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plannit_frontend/components/email_authentication_banner.dart';
import 'package:plannit_frontend/components/explore_main_components.dart';
import 'package:plannit_frontend/components/network_endpoints.dart';

//import classes
import 'explore_specified_cat.dart';
import 'package:plannit_frontend/components/search_bar.dart';
import 'package:plannit_frontend/models/category_specific_data.dart';

class ExploreWidget extends StatefulWidget {
  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  // var currUser;
  //
  // Future<bool> getCurrUser() {
  //   return (await FirebaseAuth.instance.currentUser.emailVerified;
  // }
  //
  // void initState() {
  //   super.initState();
  //   getCurrUser();
  // }
  // Init list of featured categories in the main Explore menu
  List<String> featuredCats = [
    "Ăn uống",
    "Giải trí",
    "Địa danh",
    "Chợ",
    "Mua sắm",
    "Sức khỏe",
    "Di chuyển",
    "Chỗ ở",
  ];

  // Building the main Explore menu
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width, // width of the phone's screen
                    height: MediaQuery.of(context)
                        .size
                        .height, // height of the phone's screen
                    color: Color(0xfffff5f5),
                  ),
                  Column(
                    children: [
                      // Search bar
                      ExploreMainSearchBar(),

                      // Horizonal listview menu
                      // of all available Plannit categories
                      CategoryMenu(),

                      // Display a banner if user's email is not verified
                      // w/ button for resending the auth email
                      if(!FirebaseAuth.instance.currentUser.emailVerified)
                        EmailAuthenticationBanner(),
                    ],
                  ),
                ],
              ),
            ),
            expandedHeight: FirebaseAuth.instance.currentUser.emailVerified ? 250 : 410,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Column(
                  children: [
                    // Featured category's name
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: FeaturedCategory(
                        featuredCat: featuredCats[index],
                      ),
                    ),

                    // Featured category's first 15 cards of Explore items
                    Stack(
                      children: [
                        // Decoration background for Explore cards
                        Container(
                          height: 370,
                          color: Colors.black12,
                        ),

                        // Building the Explore cards
                        FutureBuilder(
                          future: fetchExploreJson(
                              CategorySpecificData.catMap[featuredCats[index]],
                              0),
                          builder: (context, snapshot) {
                            // If has data, read it
                            if (snapshot.hasData) {
                              return BusinessHorizontalListView(
                                exploreList: snapshot.data,
                                needSmallCard: true,
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }

                            // By default, show a loading spinner
                            return CircularProgressIndicator();
                          },
                        ),
                        //BusinessHorizontalListView(),
                      ],
                    ),
                  ],
                );
              },
              childCount: featuredCats.length,
            ),
          ),
        ],
      ),
    );
  }
}
