import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference bannerRef =
      FirebaseFirestore.instance.collection('slider');
  CollectionReference venders =
      FirebaseFirestore.instance.collection('vendors');
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  FirebaseStorage storage = FirebaseStorage.instance;
  Future<DocumentSnapshot> getAdminCredential(id) async {
    var result =
        await FirebaseFirestore.instance.collection('Admin').doc(id).get();
    return result;
  }
  //banner

  Future<String> uploadImageDB(url) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      firestore.collection('slider').add({'image': downloadUrl});
    }
    return downloadUrl;
  }

  deleteBanner(id) async {
    await firestore.collection('slider').doc(id).delete();
  }

//vender
  updtateVenderStatus(String id, bool status) async {
    try {
      await firestore
          .collection('vendors')
          .doc(id)
          .update({'accVerified': status ? false : true});
    } catch (e) {
      debugPrint('$e');
    }
  }

  updtateVenderTopPicked(String id, bool toPicked) async {
    try {
      await firestore
          .collection('vendors')
          .doc(id)
          .update({'isTopPicked': toPicked ? false : true});
    } catch (e) {
      debugPrint('$e');
    }
  }

//category
  Future<String> uploadCategoryDB(url, categoryName) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      firestore
          .collection('category')
          .doc(categoryName)
          .set({'image': downloadUrl, 'name': categoryName});
    }
    return downloadUrl;
  }

  Future<void> confromDeleteDialog({title, message, context, id}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deleteBanner(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog({title, message, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
