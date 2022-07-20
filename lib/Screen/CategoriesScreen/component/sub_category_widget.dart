import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_panel/services/firbase_services.dart';

class SubCategoryWidget extends StatefulWidget {
  final String categoryName;
  SubCategoryWidget({Key key, this.categoryName}) : super(key: key);

  @override
  _SubCategoryWidgetState createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  FirebaseServices _services = FirebaseServices();

  final _subCategoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 300,
        // color: Colors.pink,
        //child: Icon(Icons.category),
        child: FutureBuilder<DocumentSnapshot>(
          future: _services.category.doc(widget.categoryName).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) {
                return Text('No sub category Added');
              }
              Map<String, dynamic> data = snapshot.data.data();
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Row(
                            children: [
                              Text('Main Category : '),
                              Text(
                                widget.categoryName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  //Sub category list

                  Container(
                    child: Expanded(
                      child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue.withOpacity(0.5),
                                  radius: 24,
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text(data['subCat'][index]['name']),
                              ),
                            );
                          },
                          itemCount: data['subCat'] == null
                              ? 0
                              : data['subCat'].length),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Add new sub category',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 30,
                                      child: TextField(
                                        controller: _subCategoryController,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            hintText: 'Enter Category Name',
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                      color: Colors.black54,
                                      onPressed: () {
                                        if (_subCategoryController
                                            .text.isEmpty) {
                                          return _services.showMyDialog(
                                              title: 'Sub category',
                                              message:
                                                  "Please provide sub category name",
                                              context: context);
                                        }
                                        DocumentReference doc = _services
                                            .category
                                            .doc(widget.categoryName);
                                        doc.update({
                                          'subCat': FieldValue.arrayUnion([
                                            {
                                              'name':
                                                  _subCategoryController.text
                                            }
                                          ])
                                        });
                                        setState(() {});
                                        _subCategoryController.clear();
                                      },
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
