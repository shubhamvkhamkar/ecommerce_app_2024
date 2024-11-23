import 'package:ecommerce_app_2024/model/authentication/auth_screen.dart';
import 'package:ecommerce_app_2024/model/screens/fav_screen.dart';
import 'package:ecommerce_app_2024/model/screens/reset_password_log_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/screens/product_detail_screen.dart';
import '../provider/cart_provider.dart';
import '../provider/product_providers.dart';

class HomeDrawer extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return Drawer(

      backgroundColor: Colors.blue.shade100,
      child: Padding(
        padding: EdgeInsets.zero,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: user != null ? Text('Welcome , \n ${user?.email}',
                style: TextStyle(color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),)
                  : Text('Welcome!'),
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.orange,),
              title: Text('My Favorites', style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavScreen(),));
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.orange,),
              title: Text('About Us', style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip, color: Colors.orange,),
              title: Text('Privacy policy', style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.orange,),
              title: Text('Reset Password', style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:
                (context) => ResetPasswordLoggedInScreen(),
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.orange,),
              title: Text('Log Out', style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthScreen(),));
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('LogOut Successfully')));
              },
            ),
          ],
        ),
      ),
    );
  }
}