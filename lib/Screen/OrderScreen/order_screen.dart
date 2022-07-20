import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_admin_panel/Screen/HomeScreen/component/sidebar_widget.dart';

class OrderScreen extends StatelessWidget {
  static const id = 'order-screen';
  OrderScreen({Key key}) : super(key: key);
  SideBarWidget _barWidget = SideBarWidget();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Admin panel'),
      ),
      sideBar: _barWidget.sideBarMenu(context, OrderScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Text(
            'Orders',
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
