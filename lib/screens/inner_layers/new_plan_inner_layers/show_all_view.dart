// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:plannit_frontend/models/explore_data.dart';
// import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/example_business_ver1.dart';
// import 'package:plannit_frontend/screens/inner_layers/explore_inner_layers/explore_specified_cat.dart';
//
// import 'business_stack.dart';
//
//
// class ShowAllView extends StatefulWidget {
//   @override
//   _ShowAllViewState createState() => _ShowAllViewState();
// }
//
// class _ShowAllViewState extends State<ShowAllView> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: fetchJson(widget.currCat),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return CustomScrollView(
//               physics: BouncingScrollPhysics(),
//               slivers: [
//                 SliverAppBar(
//                   floating: true,
//                   automaticallyImplyLeading: false,
//                   flexibleSpace: FlexibleSpaceBar(
//                     background: Stack(
//                       children: [
//                         CategoryMenuBackground(),
//                         Column(
//                           children: [
//                             BusinessSearchBar(
//                               chosenOnes: chosenOnes,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   expandedHeight: 100,
//                 ),
//                 SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                         (context, index) {
//                       return Padding(
//                         padding:
//                         EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                         child: BusinessCard(
//                           business: snapshot.data[index],
//                           currCatIndex: widget.currCatIndex,
//                           chosenOnes: chosenOnes,
//                         ),
//                       );
//                     },
//                     childCount: snapshot.data.length,
//                   ),
//                 ),
//               ],
//             );
//           } else if (snapshot.hasError) {
//             return Text("${snapshot.error}");
//           }
//
//           // By default, show a loading spinner
//           return CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }
//
// class BusinessCard extends StatelessWidget {
//   final business;
//   final currCatIndex;
//   final chosenOnes;
//
//   BusinessCard({this.business, this.currCatIndex, this.chosenOnes});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ExampleBusinessWidget(
//               currCatIndex: currCatIndex,
//               chosenOnes: chosenOnes,
//               businessId: business.business_id,
//             ),
//           ),
//         );
//       },
//       child: Card(
//         elevation: 10,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             bottomRight: Radius.circular(30),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             BusinessPic(),
//             Container(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Flexible(
//                         child: BusinessName(
//                           name: business.name,
//                           //titleTheme: titleTheme,
//                         ),
//                       ),
//                       Flexible(
//                         child: BusinessDistance(
//                           distance: "0.3km",
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 2.5),
//                   ),
//                   BusinessRating(rating: business.rating.toString() + "/5.0"),
//                   Padding(
//                     padding: EdgeInsets.only(top: 2.5),
//                   ),
//                   BusinessPrice(price: business.price_range),
//                   Padding(
//                     padding: EdgeInsets.only(top: 2.5),
//                   ),
//                   BusinessAddress(address: business.address),
//                   Padding(
//                     padding: EdgeInsets.only(top: 2.5),
//                   ),
//                   //BusinessAttributes(attributes: ["Delivery"]),
//                   Padding(
//                     padding: EdgeInsets.only(top: 2.5),
//                   ),
//                   BusinessHours(open_hours: business.open_hours),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class BusinessHours extends StatelessWidget {
//   final String open_hours;
//
//   BusinessHours({this.open_hours});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text("Open"),
//         Padding(
//           padding: EdgeInsets.only(left: 5),
//         ),
//         Text(open_hours),
//       ],
//     );
//   }
// }
//
// class BusinessAttributes extends StatelessWidget {
//   final List attributes;
//
//   BusinessAttributes({this.attributes});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 20,
//       width: 90,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: attributes.length,
//         itemBuilder: (context, index) {
//           return Row(
//             children: [
//               Icon(
//                 Icons.check,
//                 color: Colors.green,
//                 size: 15,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 5),
//               ),
//               Text(attributes[index]),
//               Padding(
//                 padding: EdgeInsets.only(left: 5),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// class BusinessPrice extends StatelessWidget {
//   final price;
//
//   const BusinessPrice({this.price});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(price),
//     );
//   }
// }
//
// class BusinessName extends StatelessWidget {
//   final String name;
//   final titleTheme;
//
//   const BusinessName({this.name, this.titleTheme});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       name,
//       style: titleTheme,
//       overflow: TextOverflow.ellipsis,
//       softWrap: true,
//     );
//   }
// }
//
// class BusinessDistance extends StatelessWidget {
//   final distance;
//
//   const BusinessDistance({this.distance});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       distance,
//       style: TextStyle(
//         color: Colors.black45,
//       ),
//     );
//   }
// }
//
// class BusinessAddress extends StatelessWidget {
//   final String address;
//
//   const BusinessAddress({this.address}) : assert(address != null);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(
//         address,
//         style: TextStyle(color: Colors.black45),
//       ),
//     );
//   }
// }
//
// class BusinessRating extends StatelessWidget {
//   final rating;
//
//   const BusinessRating({this.rating});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(rating),
//     );
//   }
// }
//
// class BusinessPic extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: FractionallySizedBox(
//         widthFactor: 1,
//         heightFactor: 1,
//         child: ClipRRect(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//           ),
//           child: Image.asset(
//             "assets/images/ho_guom.png",
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CategoryMenuBackground extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       color: Color(0xfffff5f5),
//     );
//   }
// }
//
// // class BusinessSearchBar extends StatelessWidget {
// //   final List<String> list = List.generate(10, (index) => "Text $index");
// //   final chosenOnes;
// //
// //   BusinessSearchBar({this.chosenOnes});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
// //       child: Card(
// //         elevation: 10,
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(20.0),
// //         ),
// //         color: Colors.white,
// //         child: Container(
// //           padding: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 5),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               GestureDetector(
// //                 child: Icon(
// //                   Icons.arrow_back_ios,
// //                   color: Colors.black,
// //                 ),
// //                 onTap: () {
// //                   Navigator.pop(context, chosenOnes);
// //                 },
// //               ),
// //               GestureDetector(
// //                 onTap: () {
// //                   showSearch(context: context, delegate: Search(list));
// //                 },
// //                 child: Row(
// //                   children: [
// //                     Icon(
// //                       Icons.search,
// //                       color: Colors.black12,
// //                     ),
// //                     Text(
// //                       "Find your next exploration",
// //                       style: TextStyle(fontSize: 18, color: Colors.black12),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Icon(
// //                 Icons.filter_list,
// //                 color: Colors.black,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // Network fetching & parsing
// Future<List<ExploreData>> fetchJson(String category) async {
//   try {
//     http.Response response =
//     await http.get('http://10.0.2.2:5000/get_business/$category');
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       List<ExploreData> exploreList = await parseJson(response.body);
//       return exploreList;
//     }
//   } catch (error) {
//     print("Failed to fetch data: " + category);
//     print(error);
//   }
// }
//
// List<ExploreData> parseJson(String response) {
//   List<ExploreData> exploreList = [];
//
//   if (response == null) {
//     return exploreList;
//   }
//
//   final parsed = jsonDecode(response.toString());
//   parsed.forEach((map) => {exploreList.add(ExploreData.fromJson(map))});
//
//   return exploreList;
// }