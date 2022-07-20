import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_panel/constants.dart';
import 'package:web_admin_panel/services/firbase_services.dart';

class VenderInfoCard extends StatefulWidget {
  final String id;
  VenderInfoCard({Key key, this.id}) : super(key: key);

  @override
  _VenderInfoCardState createState() => _VenderInfoCardState();
}

class _VenderInfoCardState extends State<VenderInfoCard> {
  FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _services.venders.doc(widget.id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: 400,
              child: ListView(
                children: [
                  SizedBox(
                    height: 250,
                    width: 300,
                    child: Image.network(
                      snapshot.data['image-url'],
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data['shopName'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(snapshot.data['dialoage'])
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 5,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Contact",
                                style: kVenderTextStyle,
                              ),
                            )),
                            Container(
                              child: Text(':'),
                            ),
                            Expanded(
                                child: Container(
                              child: Text(snapshot.data['contactNo']),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Email",
                                style: kVenderTextStyle,
                              ),
                            )),
                            Container(
                              child: Text(':'),
                            ),
                            Expanded(
                                child: Container(
                              child: Text(snapshot.data['email']),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Text(
                                "Address",
                                style: kVenderTextStyle,
                              ),
                            )),
                            Container(
                              child: Text(':'),
                            ),
                            Expanded(
                                child: Container(
                              child: Text(snapshot.data['address']),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Wrap(
                      children: [
                        DetailBox(
                          icon: CupertinoIcons.money_dollar_circle,
                          title: "Total Revenue",
                          rate: '26000',
                        ),
                        DetailBox(
                          icon: CupertinoIcons.cart_fill,
                          title: "Active Order",
                          rate: '26',
                        ),
                        DetailBox(
                          icon: CupertinoIcons.bag_fill,
                          title: "Orders",
                          rate: '120',
                        ),
                        DetailBox(
                          icon: Icons.grain_outlined,
                          title: "Products",
                          rate: '2600',
                        ),
                        DetailBox(
                          icon: CupertinoIcons.square_list_fill,
                          title: "Statement",
                          rate: '',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class DetailBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String rate;
  const DetailBox({
    Key key,
    this.icon,
    this.title,
    this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Card(
        color: Colors.orangeAccent.withOpacity(0.9),
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 45,
              color: Colors.black54,
            ),
            Text(
              title,
              style: kVendorInfoBoxStyle,
            ),
            Text(
              rate,
              style: kVendorInfoBoxStyle,
            )
          ],
        ),
      ),
    );
  }
}
