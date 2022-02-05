
import 'package:flutter/material.dart';

class CustomDropdownButtonWidget extends StatefulWidget {
  CustomDropdownButtonWidget({Key key, this.instance, this.mensaje, this.isVisible, @required this.onChanged})
      : super(key: key);

  final bool isVisible;
  final ValueChanged<String> onChanged;
  final List<String> instance;
  final String mensaje;
  @override
  _CustomDropdownButtonWidgetState createState() => _CustomDropdownButtonWidgetState();
}

class _CustomDropdownButtonWidgetState extends State<CustomDropdownButtonWidget> {
  
void _selectOption( String value) {
    setState(() {
       widget.onChanged(value);   
    });
  }

  int _indexList;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child:   new DropdownButton<String>(
     itemHeight: 60,
     hint:new Text(widget.mensaje),
     value: _indexList == null? null: widget.instance[_indexList],
     isExpanded: true,
     items: widget.instance.map((String value){
   return new DropdownMenuItem<String>(
      value: value,
      child:  new Text(value),
      );
  }).toList(),
  onChanged: (value) {
    setState(() {
   _indexList =  widget.instance.indexOf(value);
   _selectOption(value);
   print(value);
    });
  })
    );
  }
                
  
  
}

