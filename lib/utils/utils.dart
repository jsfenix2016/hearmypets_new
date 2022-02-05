//import 'dart:io';

//import 'package:compressimage/compressimage.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:image_picker/image_picker.dart';

class Utils {}

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

String calculateAge(DateTime birthDate) {
  if (birthDate == null) {
    return "";
  }
  var edad;
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  if (age >= 2) {
    edad = age.toString() + " años";
  } else if (age == 1) {
    edad = age.toString() + " año";
  } else if (age < 1) {
    edad = age.toString() + " meses";
  }
  return edad;
}

Future<File> procesarImagen(ImageSource origen) async {
  final XFile image = await ImagePicker().pickImage(source: origen);
  // File image = await ImagePicker.pickImage(source: origen);
  File file;
  if (image == null) {
    return file;
  }
  file = File(image.path);

  // await CompressImage.compress(
  //     imageSrc: image.path,
  //     desiredQuality: 80); //desiredQuality ranges from 0 to 100
  // print("FILE SIZE  AFTER: " + image.toString());
  return file;
}

Future<Image> getImage(String urlImage) async {
  final usuarioProvider = new UsuarioProvider();
  return new Image.memory(await usuarioProvider.buscarImagen(urlImage),
      fit: BoxFit.cover, width: double.infinity, height: 250.0);
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Informacion incorrecta"),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
