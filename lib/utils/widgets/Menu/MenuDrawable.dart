import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:heartmypet/utils/Banner/banner.dart';
import 'package:heartmypet/utils/widgets/Menu/cellmenu.dart';

// ignore: must_be_immutable
class CustomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.white,
            // ColorPalette.principal,
            Colors.white,
          ],
        ),
      ),
      child: new ListView(
        children: <Widget>[
          // new UserAccountsDrawerHeader(
          //   accountName: new Text("aaaa"),
          //   currentAccountPicture: new CircleAvatar(
          //     backgroundColor: Colors.transparent,
          //     // child: imageNet(),
          //   ),
          //   accountEmail: null,
          // ),
          SizedBox(
            height: 20,
          ),
          new cellMenu('Profile'.tr, "miUser"),
          new Divider(),
          new cellMenu('My_pets'.tr, "mismascotas"),

          new Divider(),
          new cellMenu('I_like'.tr, "misLike"),

          new Divider(),
          new cellMenu("Chat", "misLike"),

          new Divider(),
          new cellMenu("Mascotas extraviadas", "mismascotas"),

          new Divider(),
          new cellMenu("Cerrar", "login"),

          SizedBox(
            height: 40,
          ),
          BannerCustom(),
        ],
      ),
    );
    return InkWell(
      child: Container(
        child: new Drawer(
          child: fondoMorado,
        ),
      ),
    );
  }
}
