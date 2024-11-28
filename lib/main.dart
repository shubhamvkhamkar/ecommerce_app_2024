import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_2024/model/authentication/auth_screen.dart';
import 'package:ecommerce_app_2024/model/screens/splash_screen/splash_screen.dart';
import 'package:ecommerce_app_2024/provider/auth_providers.dart';
import 'package:ecommerce_app_2024/provider/product_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/admin/admin_panel_screen.dart';
import 'model/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProviders(),),
        ChangeNotifierProvider(create: (context) => AuthProviders(),)
      ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce-2024',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/admin': (context) => AdminPanelScreen(),
        '/auth' : (context) => AuthScreen(),

      }
    );
  }
}


