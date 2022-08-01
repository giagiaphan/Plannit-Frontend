/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

// import libraries
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

// import classes
import 'sign_in.dart';
import 'sign_up.dart';


class UserVerificationWidget extends StatefulWidget {
  @override
  _UserVerificationWidgetState createState() => _UserVerificationWidgetState();
}

class _UserVerificationWidgetState extends State<UserVerificationWidget> {
  final themeColor = 0xffffcbc2;
  final iconSize = 35.0;
  final spacing = 15.0;

  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 13.0);
  TextStyle linkStyle = TextStyle(color: Colors.blue);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Plannit"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color(0xfffff5f5), //cocktail pink
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    child: Text(
                      "Đăng nhập Plannit bằng tài khoản email và mật khẩu của bạn.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                  ),
                  PlannitBadge(),
                ],
              ),
              Column(
                children: [
                  // ContinueWithFacebookButton(),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 10),
                  // ),
                  // ContinueWithGoogleButton(),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 10),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SignInButton(),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      SignUpButton(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: defaultStyle,
                        children: [
                          TextSpan(text: "Tiếp tục, bạn đồng ý với "),
                          TextSpan(
                              text: "Điều khoản sử dụng",
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("Tapped ToS");
                                }),
                          TextSpan(text: " của Plannit và bạn đã đọc "),
                          TextSpan(
                              text: "Điều khoản bảo mật",
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("Tapped PP");
                                }),
                          TextSpan(text: " của Plannit."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlannitBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: SvgPicture.asset(
        'assets/icons/OFFICIAL_LOGO.svg',
      ),
    );
  }
}

class ContinueWithFacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(10),
      onPressed: () {
        // sign in with facebook account
      },
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(right: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'assets/icons/facebook.svg',
              ),
            ),
            Text(
              "Tiếp tục bằng tài khoản Facebook",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      color: Colors.blue[900],
    );
  }
}

class ContinueWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(10),
      onPressed: () {
        // sign in with google account
      },
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(right: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                'assets/icons/google.svg',
              ),
            ),
            Text(
              "Tiếp tục bằng tài khoản Google",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      color: Colors.white,
    );
  }
}

class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RaisedButton(
        padding: EdgeInsets.all(10),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpWidget()),
          );
        },
        elevation: 5,
        child: Text(
          "Đăng kí",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        color: Colors.grey,
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RaisedButton(
        padding: EdgeInsets.all(10),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInWidget()),
          );
        },
        elevation: 5,
        child: Text(
          "Đăng nhập",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        color: Colors.deepPurple,
      ),
    );
  }
}
