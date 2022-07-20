import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_admin_panel/Screen/CategoriesScreen/component/add_category_widget.dart';
import 'package:web_admin_panel/Screen/CategoriesScreen/component/category_list_widget.dart';
import 'package:web_admin_panel/Screen/HomeScreen/component/sidebar_widget.dart';

class CategoriesScreen extends StatelessWidget {
  static const id = 'category-screen';
  CategoriesScreen({Key key}) : super(key: key);
  SideBarWidget _barWidget = SideBarWidget();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Admin panel'),
      ),
      sideBar: _barWidget.sideBarMenu(context, CategoriesScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add new Category and sub category'),
              Divider(
                thickness: 5,
              ),
              AddCategoryWidget(),
              Divider(
                thickness: 5,
              ),
              CategoryListWidget()
            ],
          ),
        ),
      ),
    );
  }
}
