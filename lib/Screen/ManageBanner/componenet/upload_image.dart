import 'dart:html';

import 'package:ars_dialog/ars_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:web_admin_panel/services/firbase_services.dart';

class UploadBannerImage extends StatefulWidget {
  const UploadBannerImage({Key key}) : super(key: key);

  @override
  State<UploadBannerImage> createState() => _UploadBannerImageState();
}

class _UploadBannerImageState extends State<UploadBannerImage> {
  final FirebaseServices _services = FirebaseServices();

  bool _visible = false;
  bool imageSelected = true;
  String _path;
  final TextEditingController _filenameController = TextEditingController();
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
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: SizedBox(
                        height: 30,
                        width: 300,
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
                FlatButton(
                    color: Colors.black54,
                    onPressed: () {
                      uploadStorage();
                    },
                    child: const Text(
                      'upload Image',
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  width: 10,
                ),
                AbsorbPointer(
                  absorbing: imageSelected,
                  child: FlatButton(
                      color: imageSelected ? Colors.black12 : Colors.black54,
                      onPressed: () async {
                        progressDialog.show();
                        await _services
                            .uploadImageDB(_path)
                            .then((downloadUrl) {
                          if (downloadUrl != null) {
                            progressDialog.dismiss();
                            _services.showMyDialog(
                                context: context,
                                message: "Banner Added Successfully",
                                title: "Success");
                          }
                        });
                      },
                      child: const Text(
                        'Save Iamge',
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
            child: FlatButton(
                color: Colors.black54,
                onPressed: () {
                  setState(() {
                    _visible = true;
                  });
                },
                child: const Text(
                  'Upload new Banner',
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
    final path = 'bannerImage/$dateTime';
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
