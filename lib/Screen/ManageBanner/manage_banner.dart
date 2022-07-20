import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_admin_panel/Screen/HomeScreen/component/sidebar_widget.dart';

import 'componenet/banner_widget.dart';
import 'componenet/upload_image.dart';

class ManageBanner extends StatefulWidget {
  static const id = 'banner-screen';
  const ManageBanner({Key key}) : super(key: key);

  @override
  State<ManageBanner> createState() => _ManageBannerState();
}

class _ManageBannerState extends State<ManageBanner> {
  final SideBarWidget _barWidget = SideBarWidget();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5));
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Admin panel'),
      ),
      sideBar: _barWidget.sideBarMenu(context, ManageBanner.id),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'ManageBanner',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
                Text('Add / Delete banners'),
                Divider(
                  height: 5,
                ),
                //Banners
                BannerWidget(),
                UploadBannerImage(),
                Divider(
                  height: 5,
                ),
              ],
            )),
      ),
    );
  }
}
