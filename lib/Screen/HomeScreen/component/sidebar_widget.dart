import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_admin_panel/Screen/Adminuser/admin_user.dart';
import 'package:web_admin_panel/Screen/CategoriesScreen/categories_screen.dart';
import 'package:web_admin_panel/Screen/LoginScreen/login.dart';
import 'package:web_admin_panel/Screen/ManageBanner/manage_banner.dart';
import 'package:web_admin_panel/Screen/NotificationScreen/notification_screen.dart';
import 'package:web_admin_panel/Screen/OrderScreen/order_screen.dart';
import 'package:web_admin_panel/Screen/SetttingScreen/setting_screen.dart';
import 'package:web_admin_panel/Screen/VenderScreen/vender_screen.dart';

import '../home_screem.dart';

class SideBarWidget {
  sideBarMenu(context, selectedRoute) {
    return SideBar(
      activeBackgroundColor: Colors.black54,
      activeIconColor: Colors.white,
      activeTextStyle: const TextStyle(color: Colors.white),
      items: const [
        MenuItem(
          title: 'Dashboard',
          route: HomeScreen.id,
          icon: Icons.dashboard,
        ),
        MenuItem(
          title: 'Banner',
          route: ManageBanner.id,
          icon: Icons.image,
        ),
        MenuItem(
          title: 'Venders',
          route: VenderScreen.id,
          icon: Icons.shopping_basket_outlined,
        ),
        MenuItem(
          title: 'Categories',
          route: CategoriesScreen.id,
          icon: Icons.category,
        ),
        MenuItem(
          title: 'Order',
          route: OrderScreen.id,
          icon: Icons.shopping_cart,
        ),
        MenuItem(
          title: 'Send Notification',
          route: NotificationScreen.id,
          icon: Icons.notifications,
        ),
        MenuItem(
          title: 'Admin Users',
          route: AdminUser.id,
          icon: Icons.person,
        ),
        MenuItem(
          title: 'Setting',
          route: SettingScreen.id,
          icon: Icons.settings,
        ),
        MenuItem(
          title: 'Exit',
          route: LoginScreen.id,
          icon: Icons.exit_to_app,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route);
        }
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: const Color(0xff444444),
        child: const Center(
          child: Text(
            'MENU',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: const Color(0xff444444),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
        )),
      ),
    );
  }
}
