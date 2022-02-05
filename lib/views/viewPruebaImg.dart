import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/utils/CheckBoxCustom/CheckBox_widget.dart';
import 'package:heartmypet/utils/ContentImage.dart';
import 'package:heartmypet/utils/Dropdown/DropDownButton.dart';
import 'package:heartmypet/utils/FondoCustom.dart';
import 'package:heartmypet/utils/agreementDialog.dart' as fullDialog;

class ViewPruebaImg extends StatefulWidget {
  @override
  _ViewPruebaImgState createState() => _ViewPruebaImgState();
}

class _ViewPruebaImgState extends State<ViewPruebaImg> {
  File foto;
  Image imgNew;
  final usuarioProvider = new UsuarioProvider();
  bool isCheck = false;

  Map<int, String> genero = {
    0: 'Macho',
    1: 'Hembra',
  };

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

  Future<void> _openAgreeDialog(context) async {
    String result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return fullDialog.CreateAgreement();
        },
        //true to display with a dismiss button rather than a return navigation arrow
        fullscreenDialog: true));
    if (result != null) {
      // letsDoSomething(true, context);

      // return true;
    } else {
      print('you could do another action here if they cancel');
      //  letsDoSomething(true, context);

      // return false;
    }
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 100.0,
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
                SizedBox(height: 20),
                ContentImageWidget(
                  onChanged: (File value) {
                    foto = value;
                  },
                ),
                CustomDropdownButton('Select_pets', true, genero,
                    (String value) {
                  print(genero[value]);
                }),
                CheckboxWidgetClass("el titulo deberia ir aqui", false, true,
                    TextDecoration.underline, (bool value) {
                  print(value);
                  _openAgreeDialog(context);
                }),
                SizedBox(height: 20),
                _crearBoton(),
                SizedBox(height: 20),
                _mostrarFoto()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mostrarFoto() {
    if (imgNew == null)
      return Image.network("http://77d17157c96a.ngrok.io/imageWeb");
    else
      return Hero(
        child: new Image.asset("assets/images/no-image.png",
            width: double.infinity, height: 300.0),
        tag: "imagen",
      );
  }

  Widget _crearBoton() {
    return ElevatedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text("Ingresar"),
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        // elevation: 0,
        // color: ColorPalette.principal,
        // textColor: Colors.white,
        onPressed: () {
          searchImages();
        });
  }

  searchImages() async {
    print("==========");

    print(DateTime.now());

    final urlImg = await usuarioProvider
        .buscarWEBImagen("dir/ImageUser/47/2020-09-20%2017:04:33.090618.png");
    print(urlImg);
    setState(() {
      imgNew = urlImg;
    });
  }
}
