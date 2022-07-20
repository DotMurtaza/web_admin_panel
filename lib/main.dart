import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screen/Adminuser/admin_user.dart';
import 'Screen/CategoriesScreen/categories_screen.dart';
import 'Screen/HomeScreen/home_screem.dart';
import 'Screen/LoginScreen/login.dart';
import 'Screen/ManageBanner/manage_banner.dart';
import 'Screen/NotificationScreen/notification_screen.dart';
import 'Screen/OrderScreen/order_screen.dart';
import 'Screen/SetttingScreen/setting_screen.dart';
import 'Screen/SplashScreen/splash_screen.dart';
import 'Screen/VenderScreen/vender_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme:
          ThemeData(primaryColor: Color(0xFFFF5733), primarySwatch: Colors.red),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ManageBanner.id: (context) => ManageBanner(),
        CategoriesScreen.id: (context) => CategoriesScreen(),
        OrderScreen.id: (context) => OrderScreen(),
        SettingScreen.id: (context) => SettingScreen(),
        NotificationScreen.id: (context) => NotificationScreen(),
        AdminUser.id: (context) => AdminUser(),
        VenderScreen.id: (context) => VenderScreen(),
      },
      home: SplashScreen(),
    );
  }
}
