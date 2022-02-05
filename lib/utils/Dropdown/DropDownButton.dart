import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartmypet/utils/Dropdown/DropDown_Controller.dart';

// ignore: must_be_immutable
class CustomDropdownButton extends StatelessWidget {
  CustomDropdownButton(
      this.title, this.isVisible, this.dicItemsw, this.onChange);

  // final Dropdown_controller c = Get.put(Dropdown_controller());
  final ValueChanged<String> onChange;
  final Map<int, String> dicItemsw;
  final String title;
  final bool isVisible;
  String titleNew;
  int _indexList;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Visibility(
            visible: isVisible,
            child: new DropdownButton<String>(
                hint: titleNew == null
                    ? new Text(title.tr)
                    : new Text(titleNew.tr),
                value: dicItemsw[_indexList],
                isExpanded: true,
                items: dicItemsw.entries.map((value) {
                  return new DropdownMenuItem<String>(
                    value: value.key.toString(),
                    child: new Text(value.value),
                  );
                }).toList(),
                onChanged: (value) {
                  titleNew = dicItemsw.values.elementAt(int.parse(value)).tr;
                  print(dicItemsw.values.elementAt(int.parse(value)));
                  // c.indexList = (c.list.indexOf(value)).obs;
                  // print(c.dicItems[value.toInt].obs);
                  onChange(value);
                  (context as Element).markNeedsBuild();
                })));
  }
}
