import 'package:flutter/material.dart';
//import 'package:intl/intl.dart'; //this is an external package for formatting date and time

class DatePickerWidget extends StatefulWidget {
  DatePickerWidget({Key key, @required this.onChanged}) : super(key: key);

  final ValueChanged<DateTime> onChanged;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePickerWidget> {
  //DateTime _selectedDate;

  void _selectOption(DateTime value) {
    setState(() {
      widget.onChanged(value);
    });
  }

  String valor = "";

  TextEditingController controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: "Fecha de nacimiento",
          ),
          readOnly: true,
          controller: controlador,
          onTap: () async {
            DateTime date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now().add(Duration(days: 1)));

            if (date != null) {
              setState(() {
                // _selectedDate = date;
                // controlador.text =
                //     '${DateFormat.yMMMd().format(_selectedDate)}';
                _selectOption(date);
              });
            }
          },
        ),
      ],
    );
  }
}
