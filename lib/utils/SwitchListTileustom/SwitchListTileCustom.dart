import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';
//import 'package:heartmypet/utils/CheckBoxCustom/CheckBox_controller.dart';

// ignore: must_be_immutable
class SwitchListTileCustom extends StatelessWidget {
  SwitchListTileCustom(this.title, this.value, this.isVisible, this.onChange);

  final String title;
  final bool isVisible;
  final ValueChanged<bool> onChange;

  bool isChecked = false;
  final bool value;

  Widget build(BuildContext context) {
    isChecked = this.value;
    return Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Visibility(
            visible: isVisible,
            child: SwitchListTile(
              value: isChecked,
              title: Text(title.tr),
              activeColor: ColorPalette.principal,
              onChanged: (value) {
                isChecked = value;
                onChange(value);

                (context as Element).markNeedsBuild();
              },
            )));
  }
}
