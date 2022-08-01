/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import library
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import classes
import '../../../main.dart';
import 'about_plannit.dart';
import 'assistant_settings.dart';
import 'customer_support.dart';
import 'gift_cards.dart';
import 'how_plannit_works.dart';
import 'invite_friends.dart';
import 'language_settings.dart';
import 'notifications.dart';
import 'partner_application.dart';
import 'payment_history.dart';
import 'payment_history.dart';
import 'personal_info.dart';
import 'qr_scanner.dart';
import 'rewards_credits.dart';
import 'package:plannit_frontend/screens/inner_layers/profile_inner_layers/payment_options.dart';
import 'package:plannit_frontend/screens/inner_layers/profile_inner_layers/add_friend.dart';
import 'package:plannit_frontend/screens/inner_layers/profile_inner_layers/friend_list.dart';
import 'package:plannit_frontend/components/email_authentication_banner.dart';
import 'package:plannit_frontend/models/user_data.dart';
import 'package:plannit_frontend/screens/user_authentication/authentication_service.dart';


class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final uid = FirebaseAuth.instance.currentUser.uid;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  ///main sections divider
  Widget divider = Container(
    margin: const EdgeInsets.only(left: 25.0, right: 25.0),
    child: const Divider(
      color: Colors.blueGrey,
      height: 50,
    ),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 60),
            child: Row(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child:
                      SvgPicture.asset("assets/icons/user_auth_page_icon.svg"),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: users.doc(uid).get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                snapshot.data.data()['username'],
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                UserData user = UserData.fromJson(
                                    snapshot.data.data(), uid);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PersonalInfoWidget(user: user)
                                  ),
                                );

                              },
                              child: Text(
                                'Thông tin người dùng',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      // By default. show a loading spinner
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          ),
          // divider,
          // Container(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25, top: 25),
          //                   child: Text(
          //                     'Cài đặt tài khoản',
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       color: Colors.black,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //
          //       GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => PaymentOptionsWidget()),
          //           );
          //         },
          //         child: Row(
          //           children: [
          //             Expanded(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Container(
          //                     padding: const EdgeInsets.only(left: 25, top: 20),
          //                     child: Text(
          //                       'Phương thức thanh toán',
          //                       style: TextStyle(
          //                         fontSize: 20,
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Container(
          //               padding: const EdgeInsets.only(right: 25, top: 15),
          //               child: Icon(
          //                 Icons.credit_card,
          //                 size: 35,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //
          //       ///***************inner-divider***************///
          //       Container(
          //         margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          //         child: const Divider(
          //           color: Colors.black,
          //           height: 50,
          //         ),
          //       ),
          //
          //       ///***************inner-divider***************///
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25),
          //                   child: Text(
          //                     'Lịch sử thanh toán',
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.only(right: 25, top: 20),
          //             child: Icon(
          //               Icons.history,
          //               size: 35,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          //         child: const Divider(
          //           color: Colors.black,
          //           height: 50,
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25),
          //                   child: Text(
          //                     'Thông báo',
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.only(right: 25, top: 20),
          //             child: Icon(
          //               Icons.notifications_active,
          //               size: 35,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          divider,

          // Display a banner if user's email is not verified
          // w/ button for resending the auth email
          if(!FirebaseAuth.instance.currentUser.emailVerified)
            EmailAuthenticationBanner(),

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 25, top: 25),
                            child: Text(
                              'Bạn bè',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddFriendWidget()),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                'Thêm bạn bè',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 30, top: 25),
                        child: SizedBox(
                          height: 30, width: 30,
                            child: SvgPicture.asset("assets/icons/search_friend.svg")),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: const Divider(
                    color: Colors.black,
                    height: 50,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FriendList()),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                'Danh sách bạn bè',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 30, top: 25),
                        child: SizedBox(
                            height: 30, width: 30,
                            child: SvgPicture.asset("assets/icons/friendlist_icon.svg")),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: const Divider(
                    color: Colors.black,
                    height: 50,
                  ),
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             padding: const EdgeInsets.only(left: 25),
                //             child: Text(
                //               'Mời bạn bè',
                //               style: TextStyle(
                //                 fontSize: 20,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       padding: const EdgeInsets.only(right: 25, top: 25),
                //       child: Icon(
                //         Icons.card_giftcard,
                //         size: 35,
                //       ),
                //     ),
                //   ],
                // ),
                // Container(
                //   margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                //   child: const Divider(
                //     color: Colors.black,
                //     height: 50,
                //   ),
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             padding: const EdgeInsets.only(left: 25, top: 25),
                //             child: Text(
                //               'Tín dụng',
                //               style: TextStyle(
                //                 fontSize: 14,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             padding: const EdgeInsets.only(left: 25, top: 20),
                //             child: Text(
                //               'Thẻ quà',
                //               style: TextStyle(
                //                 fontSize: 20,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       padding: const EdgeInsets.only(right: 25, top: 20),
                //       child: Icon(
                //         Icons.card_membership,
                //         size: 35,
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             padding: const EdgeInsets.only(left: 25, top: 12),
                //             child: Text(
                //               'Gửi hoặc sử dụng thẻ quà ',
                //               style: TextStyle(
                //                 fontSize: 14,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // Container(
                //   margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                //   child: const Divider(
                //     color: Colors.black,
                //     height: 50,
                //   ),
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             padding: const EdgeInsets.only(left: 25),
                //             child: Text(
                //               'Phần thưởng',
                //               style: TextStyle(
                //                 fontSize: 20,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       padding: const EdgeInsets.only(right: 25, top: 20),
                //       child: Icon(
                //         Icons.card_travel,
                //         size: 35,
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             padding: const EdgeInsets.only(left: 25, top: 12),
                //             child: Text(
                //               'Đổi điểm của bạn lấy phần quà',
                //               style: TextStyle(
                //                 fontSize: 14,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
          //     ],
          //   ),
          // ),
          // divider,
          // Container(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25, top: 20),
          //                   child: Text(
          //                     'Công cụ ',
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       color: Colors.black,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25, top: 20),
          //                   child: Text(
          //                     'Cài đặt Siri',
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.only(right: 25, top: 20),
          //             child: Icon(
          //               Icons.assistant,
          //               size: 35,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          //         child: const Divider(
          //           color: Colors.black,
          //           height: 50,
          //         ),
          //       ),
          //
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25),
          //                   child: Text(
          //                     'Ngôn ngữ',
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.only(right: 25, top: 20),
          //             child: Icon(
          //               Icons.language,
          //               size: 35,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          //         child: const Divider(
          //           color: Colors.black,
          //           height: 50,
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25),
          //                   child: Text(
          //                     'Giao diện',
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.only(right: 25, top: 20),
          //             child: Icon(
          //               Icons.landscape,
          //               size: 35,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          //         child: const Divider(
          //           color: Colors.black,
          //           height: 50,
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25),
          //                   child: Text(
          //                     'Cài đặt thông báo',
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.only(right: 25, top: 20),
          //             child: Icon(
          //               Icons.notifications,
          //               size: 35,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          //         child: const Divider(
          //           color: Colors.black,
          //           height: 50,
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25),
          //                   child: Text(
          //                     'Quét Mã QR',
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.only(right: 25, top: 20),
          //             child: Icon(
          //               Icons.camera,
          //               size: 35,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          //divider,
          // Container(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25, top: 35),
          //                   child: Text(
          //                     'Hỗ trợ',
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       color: Colors.black,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25, top: 20),
          //                   child: Text(
          //                     'Về Plannit',
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.only(right: 25, top: 20),
          //             child: Icon(
          //               Icons.info,
          //               size: 35,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          //         child: const Divider(
          //           color: Colors.black,
          //           height: 50,
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25),
          //                   child: Text(
          //                     'Cách Plannit hoạt động',
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.only(right: 25, top: 20),
          //             child: Icon(
          //               Icons.question_answer,
          //               size: 35,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          //         child: const Divider(
          //           color: Colors.black,
          //           height: 50,
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: const EdgeInsets.only(left: 25),
          //                   child: Text(
          //                     'Trung tâm hỗ trợ',
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.only(right: 25, top: 20),
          //             child: Icon(
          //               Icons.call,
          //               size: 35,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          //         child: const Divider(
          //           color: Colors.black,
          //           height: 50,
          //         ),
          //       ),
                GestureDetector(
                  onTap: () {
                    context.read<AuthenticationService>().signOut();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                'Đăng xuất',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 25, top: 20),
                        child: Icon(
                          Icons.time_to_leave,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
