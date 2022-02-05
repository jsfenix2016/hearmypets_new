import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:heartmypet/utils/CheckBoxCustom/CheckBox_controller.dart';

// ignore: must_be_immutable
class CheckboxWidgetClass extends StatelessWidget {
  CheckboxWidgetClass(
      this.title, this.value, this.isVisible, this.deco, this.onChange);

  //final CheckBoxController c = Get.put(CheckBoxController());

  final String title;
  final bool isVisible;
  final ValueChanged<bool> onChange;
  final TextDecoration deco;
  bool isChecked = false;
  final bool value;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0),
      padding: EdgeInsets.only(left: 8, right: 0),
      color: Colors.white,
      child: Visibility(
        visible: isVisible,
        child: new CheckboxListTile(
          value: value,
          onChanged: (value) {
            isChecked = value;
            onChange(value);

            // (context as Element).markNeedsBuild();
          },
          title: new Text(
            title.tr,
            textAlign: TextAlign.left,
            style: TextStyle(
              decoration: deco,
            ),
          ),
        ),
      ),
    );
  }
}
