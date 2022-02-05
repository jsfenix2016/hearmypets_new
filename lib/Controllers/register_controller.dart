//import 'dart:io';
//import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartmypet/blocks/register_block.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/utils/ManagerSecurity.dart';

import 'package:heartmypet/utils/utils.dart';

class RegisterController extends GetxController {
  final prefs = new PreferenciasUsuario();
  final usuarioProvider = new UsuarioProvider();

  bool isCheck = false;

  register(RegisterBloc bloc, BuildContext context, bool acepTerms) async {
    await prefs.initPrefs();

    print("==========");
    print("Email: ${bloc.email}");
    print("Password:${bloc.password}");
    //print("Terms:${bloc.terms.toString()}");

    print("==========");
    // if (isCheck == false) {
    //   mostrarAlerta(context, "Debe aceptar los terminos y condiciones.");
    //   return;
    // }
    //  Navigator.pushReplacementNamed(context, "home");
    //String imgDir = "";

    // if (foto != null) {
    //   print(DateTime.now());
    //   //final nameImage = "${DateTime.now().microsecond.toString()}";
    //   final urlImg = await usuarioProvider.subirImagen(
    //       foto, DateTime.now().microsecond.toString());
    //   print(urlImg);

    //   if (urlImg["ok"]) {
    //     imgDir = urlImg["imageUrl"];
    //   }
    // }

    var passEncryp = await ManagerSecurity().newEncryp(bloc.password);
    try {
      Map info =
          await usuarioProvider.insertRegister(bloc.email, passEncryp, isCheck);

      if (info["ok"]) {
        mostrarAlerta(context, "Registro de usuario Correcto");
        Navigator.pushReplacementNamed(context, "login");
      } else {
        mostrarAlerta(context, "Ususario o password incorrecto");
      }
    } catch (error) {
      print(error.toString());
      mostrarAlerta(context, "Algo salio mal, intente de nuevo mas tarde");
    }
  }
}
