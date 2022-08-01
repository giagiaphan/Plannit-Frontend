import 'package:firebase_auth/firebase_auth.dart';
/// This code belongs to Plannit Technologies LLC.
/// Copyright © 2021 by Plannit Technologies LLC. All rights reserved.

//import libraries
import 'package:flutter/material.dart';

class EmailAuthenticationBanner extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;

  final snackBar = SnackBar(
    content: Text('Đã gửi lại email xác nhận!'),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      padding: EdgeInsets.all(20),
      content: Text(
          'Email của bạn cần được xác nhận và sau đó đăng nhập lại.\nBạn nhớ kiểm tra cả hộp thư rác và hộp thư chính.'),
      leading: CircleAvatar(
        child: Icon(Icons.email),
      ),
      actions: [
        Padding(padding: EdgeInsets.only(right: 10)),
        FlatButton(
          child: Text('Gửi lại email xác nhận'),
          onPressed: () async {
            //resend verification email
            await user.sendEmailVerification();

            // Tell user that auth email is sent
            Scaffold.of(context).showSnackBar(snackBar);
          },
        ),
      ],
    );
  }
}