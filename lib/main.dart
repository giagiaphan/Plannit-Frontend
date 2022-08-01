/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

//import libraries
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plannit_frontend/components/push_notifications.dart';
import 'package:provider/provider.dart';

//import classes
import 'components/network_endpoints.dart';
import 'models/community_saved_plans.dart';
import 'screens/inner_layers/explore_inner_layers/explore.dart';
import 'screens/inner_layers/profile_inner_layers/profile.dart';
import 'screens/inner_layers/saved_inner_layers/saved.dart';
import 'package:plannit_frontend/models/my_saved_plans.dart';
import 'screens/user_authentication/authentication_service.dart';
import 'screens/user_authentication/user_verification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MySavedPlans(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommunitySavedPlans(),
        ),
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        home: HomeAuthenticationWrapper(),
        theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Color(0xfffff5f5),
          fontFamily: 'Helvetica',
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;

  final PushNotificationsManager _pushNotificationInstance = new PushNotificationsManager();
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    // Get the token each time the application loads
    _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      // Save the initial token to the database
      await saveTokenToDatabase(token);
    });

    // Any time the token refreshes, store this in the database too.
    _firebaseMessaging.onTokenRefresh.listen(saveTokenToDatabase);
  }

  final List<Widget> _children = [
    //CommunityWidget(),
    ExploreWidget(),
    //PlanCreator(),
    SavedWidget(),
    ProfileWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final iconSize = 25.0;
    _pushNotificationInstance.init();

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          // BottomNavigationBarItem(
          //   icon: Container(
          //     width: iconSize,
          //     height: iconSize,
          //     child: SvgPicture.asset('assets/icons/community_icon.svg'),
          //   ),
          //   label: 'Cộng đồng',
          // ),
          BottomNavigationBarItem(
            icon: Container(
              width: iconSize,
              height: iconSize,
              child: SvgPicture.asset('assets/icons/explore_icon.svg'),
            ),
            title: Text('Kham pha')
          ),
          // BottomNavigationBarItem(
          //   icon: Container(
          //     width: iconSize,
          //     height: iconSize,
          //     child: SvgPicture.asset('assets/icons/new_plan_icon.svg'),
          //   ),
          //   label: 'Tạo mới',
          // ),
          BottomNavigationBarItem(
            icon: Container(
              width: iconSize,
              height: iconSize,
              child: SvgPicture.asset('assets/icons/plan_icon.svg'),
            ),
            title: Text('Kế hoạch'),
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: iconSize,
              height: iconSize,
              child: SvgPicture.asset('assets/icons/profile_icon.svg'),
            ),
            title: Text('Về tôi'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class HomeAuthenticationWrapper extends StatelessWidget {
  const HomeAuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return Home();
    }
    return UserVerificationWidget();
  }
}