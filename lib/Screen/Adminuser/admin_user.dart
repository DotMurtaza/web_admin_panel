import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_admin_panel/Screen/HomeScreen/component/sidebar_widget.dart';

class AdminUser extends StatelessWidget {
  static const id = 'admin-user';
  AdminUser({Key key}) : super(key: key);
  SideBarWidget _barWidget = SideBarWidget();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Admin panel'),
      ),
      sideBar: _barWidget.sideBarMenu(context, AdminUser.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Text(
            'Admin User',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
