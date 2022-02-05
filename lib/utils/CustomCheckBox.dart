// import 'package:flutter/material.dart';
// import 'package:heartmypet/blocks/provider.dart';
// import 'package:heartmypet/provider/preferencia_usuario.dart';
// import 'agreementDialog.dart' as fullDialog;
// import 'package:get/get.dart';

// class CheckboxWidget extends StatefulWidget {
//   CheckboxWidget({Key key, @required this.onChanged}) : super(key: key);
//   final ValueChanged<bool> onChanged;

//   @override
//   CheckboxWidgetClass createState() => new CheckboxWidgetClass();
// }

// class CheckboxWidgetClass extends State<CheckboxWidget> {
//   bool isChecked = false;
//   final prefs = new PreferenciasUsuario();
//   // var resultHolder = 'termsLabel'.tr;

//   Future<void> _openAgreeDialog(context) async {
//     String result = await Navigator.of(context).push(MaterialPageRoute(
//         builder: (BuildContext context) {
//           return fullDialog.CreateAgreement();
//         },
//         //true to display with a dismiss button rather than a return navigation arrow
//         fullscreenDialog: true));
//     if (result != null) {
//       // letsDoSomething(true, context);

//       // return true;
//     } else {
//       print('you could do another action here if they cancel');
//       //  letsDoSomething(true, context);

//       // return false;
//     }
//   }

//   letsDoSomething(bool result, context) async {
//     await prefs.initPrefs();
//     print(result); //prints 'User Agreed'
//     // bloc.termsStream = result;
//     prefs.terms = result;

//     setState(() {
// //isChecked = result;
//       widget.onChanged(result);
//     });
//   }

//   void _onRememberMeChanged(bool newValue) => setState(() {
//         _openAgreeDialog(context);
//         //isChecked = newValue;
//         widget.onChanged(newValue);
//         isChecked = newValue;

//         if (isChecked) {
//           // TODO: Here goes your functionality that remembers the user.
//         } else {
//           // TODO: Forget the user
//         }
//       });

//   Widget build(BuildContext context) {
//     final bloc = Provider.registerBlock(context);
//     return StreamBuilder(
//       // stream: bloc.termsStream,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         return Container(
//           padding: EdgeInsets.symmetric(horizontal: 20.0),
//           child: new CheckboxListTile(
//             value: isChecked,
//             onChanged: _onRememberMeChanged,
//             title: new Text(
//               'termsLabel'.tr,
//               style: TextStyle(
//                 decoration: TextDecoration.underline,
//               ),
//             ),
//             controlAffinity: ListTileControlAffinity.leading,
//             activeColor: Colors.red,
//           ),
//         );
//       },
//     );
//   }
// }
