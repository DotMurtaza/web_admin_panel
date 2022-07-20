import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_panel/Screen/CategoriesScreen/component/sub_category_widget.dart';
import 'package:web_admin_panel/constants.dart';

class CategoryCardWidget extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoryCardWidget({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SubCategoryWidget(categoryName: snapshot['name']);
            });
      },
      child: SizedBox(
        height: 130,
        width: 120,
        child: Card(
          color: Colors.orangeAccent.withOpacity(0.9),
          elevation: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 80,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    snapshot['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  snapshot['name'],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
