
import 'package:flutter/material.dart';

class CustomDropdownButtonWidgetWithDictionary extends StatefulWidget {
  CustomDropdownButtonWidgetWithDictionary({Key key, this.instance, this.mensaje, this.isVisible, @required this.onChanged})
      : super(key: key);

  final bool isVisible;
  final ValueChanged<String> onChanged;
  final Map< int, String> instance;
  final String mensaje;
  @override
  _CustomDropdownButtonWidgetStateWithDictionary createState() => _CustomDropdownButtonWidgetStateWithDictionary();
}

class _CustomDropdownButtonWidgetStateWithDictionary extends State<CustomDropdownButtonWidgetWithDictionary> {
  
void _selectOption( String value) {
    setState(() {
       widget.onChanged(value);   
    });
  }

  int _indexList;

var _selectedLocation = '1';

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child:   new DropdownButton<String>(
     itemHeight: 60,
     hint:new Text(widget.mensaje),
     value: _selectedLocation == null? null: widget.instance[_indexList],
     isExpanded: true,
     items: widget.instance.entries.map((value){
   return new DropdownMenuItem<String>(
      value: value.key.toString(),
      child:  new Text(value.value),
      );
  }).toList(),
  onChanged: (value) {
    setState(() {
   _selectedLocation =  value;
   _selectOption(value);
   print(value);
    });
  })
    );
  }
                
  
  
}

