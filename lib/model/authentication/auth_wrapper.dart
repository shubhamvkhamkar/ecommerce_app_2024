import 'package:ecommerce_app_2024/model/authentication/auth_screen.dart';

import 'package:ecommerce_app_2024/model/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData){
            return HomeScreen();
          } else {
            return AuthScreen();
          }
        },
    );
  }

}