import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_admin_panel/Screen/HomeScreen/component/sidebar_widget.dart';

import 'component/vender_data_table_widget.dart';

class VenderScreen extends StatelessWidget {
  static const id = 'vender-screen';
  VenderScreen({Key key}) : super(key: key);
  final SideBarWidget _barWidget = SideBarWidget();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Admin panel'),
      ),
      sideBar: _barWidget.sideBarMenu(context, VenderScreen.id),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vender',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text('Manage Venders'),
                // const FilterVenderWidget(),
                const SizedBox(
                  height: 5,
                ),

                VenderDataTable(),

                //Banners
              ],
            )),
      ),
    );
  }
}
