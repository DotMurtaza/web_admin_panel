import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin_panel/Screen/VenderScreen/component/vendors_info_box.dart';
import 'package:web_admin_panel/services/firbase_services.dart';
import 'package:chips_choice/chips_choice.dart';

class VenderDataTable extends StatefulWidget {
  const VenderDataTable({Key key}) : super(key: key);

  @override
  State<VenderDataTable> createState() => _VenderDataTableState();
}

class _VenderDataTableState extends State<VenderDataTable> {
  final FirebaseServices _services = FirebaseServices();
  // simple usage
  int tag = 0;
  List<String> options = [
    'All Vendors',
    'Active Vendors',
    'Inactive Vendors',
    'Top Picked',
    'Top Rated'
  ];
  bool isTopPicked;
  bool active;
  filter(val) {
    if (val == 1) {
      setState(() {
        active = true;
      });
      if (val == 2) {
        setState(() {
          active = false;
        });
      }
      if (val == 3) {
        setState(() {
          isTopPicked = true;
        });
      }
      if (val == 0) {
        setState(() {
          isTopPicked = null;
          active = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FilterVenderWidget(),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ChipsChoice<int>.single(
              choiceActiveStyle: const C2ChoiceStyle(
                brightness: Brightness.dark,
                color: Colors.grey,
                borderShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    side: BorderSide(color: Colors.white)),
              ),
              value: tag,
              onChanged: (val) {
                setState(() {
                  tag = val;
                });
                filter(val);
              },
              choiceItems: C2Choice.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
            )),
        StreamBuilder<QuerySnapshot>(
            stream: _services.venders
                .where('isTopPicked', isEqualTo: isTopPicked)
                .where('accVerified', isEqualTo: active)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    //key: key,
                    //  dataTextStyle: TextStyle(color: Colors.black),
                    showBottomBorder: true,
                    dataRowHeight: 60,
                    headingRowColor: MaterialStateProperty.all(Colors.grey),
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Active / Inactive')),
                      DataColumn(label: Text('Top Picked')),
                      DataColumn(label: Text('Shope Name')),
                      DataColumn(label: Text('Rating')),
                      DataColumn(label: Text('Total Sales')),
                      DataColumn(label: Text('Mobile')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('View Detail')),
                    ],
                    rows: _venderDetailRow(snapshot.data, _services)),
              );
            }),
      ],
    );
  }

  List<DataRow> _venderDetailRow(
      QuerySnapshot snapshot, FirebaseServices services) {
    debugPrint('Snapshot lenght : ${snapshot.docs.length}');
    List<DataRow> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      debugPrint('Document lenght is${documentSnapshot.data()?.length}');
      // if (documentSnapshot.data() == null) {
      //   debugPrint('no data');
      // }
      return DataRow(cells: [
        DataCell(IconButton(
            onPressed: () {
              services.updtateVenderStatus(
                documentSnapshot.data()['uid'],
                documentSnapshot.data()['accVerified'],
              );
            },
            icon: documentSnapshot.data()['accVerified']
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.cancel_rounded,
                    color: Colors.red,
                  ))),
        DataCell(IconButton(
            onPressed: () {
              services.updtateVenderTopPicked(
                documentSnapshot.data()['uid'],
                documentSnapshot.data()['isTopPicked'],
              );
            },
            icon: documentSnapshot.data()['isTopPicked']
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(null))),
        DataCell(Text(documentSnapshot.data()['shopName'])),
        DataCell(Row(
          children: const [
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Text('4.2')
          ],
        )),
        const DataCell(Text('20,0000')),
        DataCell(Text(documentSnapshot.data()['contactNo'])),
        DataCell(Text(documentSnapshot.data()['email'])),
        DataCell(IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (index) {
                    return VenderInfoCard(
                      id: documentSnapshot.data()['uid'],
                    );
                  });
            },
            icon: const Icon(Icons.info_outline))),
      ]);
    }).toList();
    debugPrint('lenght is ${newList.length}');
    return newList;
  }
}
