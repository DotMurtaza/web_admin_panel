import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_panel/Screen/CategoriesScreen/component/category_card.dart';
import 'package:web_admin_panel/services/firbase_services.dart';

class CategoryListWidget extends StatelessWidget {
  CategoryListWidget({Key key}) : super(key: key);
  FirebaseServices _services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _services.category.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return Wrap(
            direction: Axis.horizontal,
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              //  Map<String, dynamic> data = document.data();
              return CategoryCardWidget(
                snapshot: document,
              );
            }).toList(),
          );
        });
  }
}
