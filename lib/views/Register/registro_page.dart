import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:heartmypet/Controllers/register_controller.dart';
import 'package:heartmypet/blocks/provider.dart';
import 'package:heartmypet/blocks/register_block.dart';
//import 'package:heartmypet/provider/preferencia_usuario.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
//import 'package:heartmypet/utils/ContentImage.dart';
//import 'package:heartmypet/utils/CustomCheckBox.dart';
import 'package:heartmypet/utils/FondoCustom.dart';
//import 'package:heartmypet/utils/utils.dart';
import 'package:get/get.dart';

import 'package:heartmypet/utils/CheckBoxCustom/CheckBox_widget.dart';

class RegistroPage extends StatelessWidget {
  File foto;
  final usuarioProvider = new UsuarioProvider();
  bool isCheck = false;
  final RegisterController lc = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FondoCustomWidget(),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.registerBlock(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 150.0,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.0),
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'register'.tr,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                // ContentImageWidget(
                //   onChanged: (File value) {
                //     foto = value;
                //   },
                // ),

                SizedBox(height: 10),
                _crearEmail(bloc),
                SizedBox(height: 10),
                _crearPassword(bloc),
                SizedBox(height: 20),
                CheckboxWidgetClass(
                    'termsLabel'.tr, isCheck, true, TextDecoration.underline,
                    (bool value) {
                  print(value);
                  isCheck = value;

                  (context as Element).markNeedsBuild();
                }),
                SizedBox(height: 20),
                _crearBoton(bloc),
              ],
            ),
          ),
          TextButton(
            child: Text('titulo_login'.tr),
            onPressed: () => Navigator.pushReplacementNamed(context, "login"),
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail(RegisterBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon:
                    Icon(Icons.alternate_email, color: ColorPalette.principal),
                hintText: 'placeholderEmail'.tr,
                labelText: 'email'.tr,
                counterText: snapshot.data,
                errorText: snapshot.error,
              ),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _crearBoton(RegisterBloc bloc) {
    return StreamBuilder(
        stream: bloc.fromValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ElevatedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('register'.tr),
            ),
            onPressed: snapshot.hasData
                ? () {
                    lc.register(bloc, context, isCheck);
                  }
                : null,
          );
        });
  }

  Widget _crearPassword(RegisterBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: ColorPalette.principal),
                labelText: 'password'.tr,
                counterText: snapshot.data,
                errorText: snapshot.error,
              ),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }
}
