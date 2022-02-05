import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartmypet/blocks/login_bloc.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/utils/ManagerSecurity.dart';
import 'package:heartmypet/utils/utils.dart';

// ignore: camel_case_types
class login_controller extends GetxController {
  final usuarioProvider = new UsuarioProvider();

  login(LoginBloc bloc, BuildContext context) async {
    print("==========");
    print("Email: ${bloc.email}");
    print("Password:${bloc.password}");
    print("==========");
    // var passEncryp = await ManagerSecurity().encrypte(bloc.password);

    var passEncryp2 = await ManagerSecurity().newEncryp(bloc.password);
    // print(passEncryp2);
    // var passDeEncryp2 = await ManagerSecurity().decryptedNew(passEncryp2);
    try {
      Map info = await usuarioProvider.loginMiApi(bloc.email, passEncryp2);
      if (info["ok"]) {
        Navigator.pushReplacementNamed(context, "home");
      } else {
        mostrarAlerta(context, "Ususario o password incorrecto".tr);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  logOut(BuildContext context) {}

  goToRegister(BuildContext context) {
    Navigator.pushReplacementNamed(context, "registro");
  }
}
