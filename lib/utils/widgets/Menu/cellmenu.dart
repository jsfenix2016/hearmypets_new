import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:heartmypet/Constant/Constant.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';

class cellMenu extends StatelessWidget {
  cellMenu(this.title, this.route);
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new ListTile(
      onTap: () {
        Navigator.pushNamed(context, this.route);
      },
      title: new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0.0, 5.0),
                spreadRadius: 0.2),
          ],
        ),
        height: 50,
        child: Row(
          children: [
            new Container(
              height: 50,
              width: size.height * 0.2803,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 5),
                child: new Text(
                  this.title.tr,
                ),
              ),
            ),
            new Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(5.0),
                    bottomRight: const Radius.circular(5.0)),
                color: ColorPalette.principal.withOpacity(0.7),
              ),
              height: 50,
              width: 60,
              child: new Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
