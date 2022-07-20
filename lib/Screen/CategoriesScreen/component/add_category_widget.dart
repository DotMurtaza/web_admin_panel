import 'dart:html';

import 'package:ars_dialog/ars_dialog.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_panel/services/firbase_services.dart';
import 'package:firebase/firebase.dart' as fb;

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({Key key}) : super(key: key);

  @override
  _AddCategoryWidgetState createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  final FirebaseServices _services = FirebaseServices();

  bool _visible = false;
  bool imageSelected = true;
  String _path;
  final TextEditingController _filenameController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CustomProgressDialog progressDialog = CustomProgressDialog(
      context,
      blur: 5,
    );
    progressDialog.setLoadingWidget(const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.red)));
    return Container(
      width: double.infinity,
      color: Colors.grey,
      height: 60,
      child: Row(
        children: [
          Visibility(
            visible: _visible,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: 30,
                    child: TextField(
                      controller: _categoryNameController,
                      decoration: const InputDecoration(
                          hintText: 'No category given',
                          contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 5,
                        child: TextField(
                          controller: _filenameController,
                          decoration: const InputDecoration(
                              hintText: 'Upload file',
                              contentPadding:
                                  EdgeInsets.only(left: 10, bottom: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              filled: true,
                              fillColor: Colors.white),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                // ignore: deprecated_member_use
                FlatButton(
                    minWidth: MediaQuery.of(context).size.width / 10,
                    color: Colors.black54,
                    onPressed: () {
                      uploadStorage();
                    },
                    child: const Text(
                      'upload Category',
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  width: 10,
                ),
                AbsorbPointer(
                  absorbing: imageSelected,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      minWidth: MediaQuery.of(context).size.width / 10,
                      color: imageSelected ? Colors.black12 : Colors.black54,
                      onPressed: () async {
                        if (_categoryNameController.text.isEmpty) {
                          return _services.showMyDialog(
                              context: context,
                              title: 'Category Name',
                              message: "Category Name Not Given");
                        }
                        progressDialog.show();
                        await _services
                            .uploadCategoryDB(
                                _path, _categoryNameController.text)
                            .then((downloadUrl) {
                          if (downloadUrl != null) {
                            progressDialog.dismiss();
                            _services.showMyDialog(
                                context: context,
                                message: "Category Added Successfully",
                                title: "Success");
                          }
                        });
                        _categoryNameController.clear();
                        _filenameController.clear();
                      },
                      child: const Text(
                        'Save Category',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Visibility(
            visible: _visible ? false : true,
            // ignore: deprecated_member_use
            child: FlatButton(
                minWidth: MediaQuery.of(context).size.width / 10,
                color: Colors.black54,
                onPressed: () {
                  setState(() {
                    _visible = true;
                  });
                },
                child: const Text(
                  'Upload new Category',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }

  void uploadImage({Function(File file) onSelected}) {
    FileUploadInputElement uploadInput = FileUploadInputElement()
      ..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files.first;

      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  void uploadStorage() async {
    //upload to firbase Storage
    final dateTime = DateTime.now();
    final path = 'categoryImage/$dateTime';
    uploadImage(onSelected: (file) {
      if (file != null) {
        setState(() {
          _filenameController.text = file.name;
          imageSelected = false;
          _path = path;
        });
        fb
            .storage()
            .refFromURL('gs://food-app-553e0.appspot.com')
            .child(path)
            .put(file);
      }
    });
  }
}
