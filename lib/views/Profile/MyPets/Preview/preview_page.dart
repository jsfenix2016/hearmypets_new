//import 'package:heartmypet/Constant/colorsPalette.dart';
import 'dart:io';

import 'package:heartmypet/Constant/Constant.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/Model/user_model.dart';
import 'package:heartmypet/blocks/user_block.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/utils/Banner/banner.dart';
import 'package:heartmypet/utils/Location/locationCustomNew.dart';
import 'package:heartmypet/utils/datePickerCustom.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
//import 'package:heartmypet/utils/locationCustom.dart';
import 'package:heartmypet/utils/utils.dart';
import 'package:heartmypet/utils/widgets/Like/likebutton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:heartmypet/blocks/provider.dart';
//import 'package:compressimage/compressimage.dart';
import 'package:heartmypet/utils/CustomDropdowButton.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';

//import 'package:geolocator/geolocator.dart';

// // COMPLETE: Import google_mobile_ads.dart
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class PreviewPage extends StatefulWidget {
  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pref = new PreferenciasUsuario();
  DateTime dateNew = DateTime.now();
  UserBlock userBloc;
  File foto;
  ProductoModel prodDataTemp = new ProductoModel();
  bool like = false;
  final usuarioProvider = new UsuarioProvider();

  bool isVisibleGenero = false;
  bool isVisibleTamano = false;
  bool isVisiblePedigree = false;
  String mascota;
  var listGeneric = <String>[];

  Image imgNew;
  String generoText = "Cual es tu genero";
  String titleEnfermedad = "Padece enfermedad";
  String placeholderEdad = "Ingresa una edad";
  String titleEdad = "Edad";
  String tituloVista = "Perfil";
  String lblTituloDescripcion = "Mi descripción";
  String tituloDescripcionEnfermedad = "Descripción enfermedad";

  Future<Image> getImage(String urlImage) async {
    return imgNew = new Image.memory(
        await usuarioProvider.buscarImagen(urlImage),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250.0);
  }

  @override
  Widget build(BuildContext context) {
    userBloc = Provider.userBloc(context);
    final size = MediaQuery.of(context).size;
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    tituloVista = "Pre-visualización";
    if (prodData != null) {
      prodDataTemp = prodData;

      //tituloVista = "Visualización de la mascota";
    }

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //title: Center(child: Text(tituloVista)),
      ),
      floatingActionButton: LikeButton(like),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                children: [
                  _mostrarFoto(size),
                  Container(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Center(child: _crearNombre(prodDataTemp.namePet)),
                            separatorLine(),
                            contentInfo(),
                            separatorLine(),
                            Center(
                              child: Text(
                                prodDataTemp.description,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 40),
                            BannerCustom(),
                            // if (_isBannerAdReady) banners(),
                            SizedBox(height: 40),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget separatorLine() {
    return Column(
      children: [
        SizedBox(height: 20),
        SizedBox(
          height: 1,
          child: Container(
            color: ColorPalette.principal.withOpacity(0.2),
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }

  Widget _crearNombre(String nombre) {
    return Text(nombre,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20));
  }

  Widget iconText(String texto, String titulo, String iconUrl) {
    return new Container(
      child: Column(
        children: [
          new Image.asset(
            iconUrl,
            width: 60.0,
            height: 60.0,
            fit: BoxFit.cover,
          ),
          Text(titulo,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14)),
          Text(texto,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 12))
        ],
      ),
    );
  }

  Widget contentInfo() {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconText("${prodDataTemp.genero}", "Genero:",
              "assets/images/icoGender.png"),
          iconText(
              calculateAge(DateTime.parse(prodDataTemp.birthDate)).toString(),
              "Edad:",
              "assets/images/iconAge.png"),
          iconText("Perro", "Tipo:", "assets/images/mascotas.jpg"),
          iconText("${Constant.tamanoDic[0]}", "Tamaño:",
              "assets/images/iconHeight.png"),
        ],
      ),
    );
  }

  _createBottom(BuildContext context) {
    return FloatingActionButton(
      child: IconButton(
        iconSize: 30,
        color: like == false ? Colors.grey : Colors.red,
        icon: Icon(Icons.favorite),
        onPressed: () {
          like = like == false ? true : false;
          (context as Element).markNeedsBuild();
        },
      ),
      backgroundColor: Colors.white,
      onPressed: () {
        //createPlantFoodNotification();
        // Navigator.pushNamed(context, "miUser");
      },
    );
  }

  Widget _mostrarFoto(Size size) {
    // if (userModel.image_1 != null && userModel.image_1 != "") {
    //   return ClipRRect(
    //     borderRadius: BorderRadius.only(
    //         bottomLeft: const Radius.circular(10.0),
    //         bottomRight: const Radius.circular(10.0)),
    //     //make border radius more than 50% of square height & width
    //     child: FadeInImage(
    //       image: new NetworkImage(userModel.image_1),
    //       placeholder: new AssetImage("assets/images/no-image.png"),
    //       height: 200.0,
    //       width: double.infinity,
    //       fit: BoxFit.fill,
    //     ),
    //   );
    // }
    // if (foto != null)
    //   return ClipRRect(
    //     borderRadius: BorderRadius.only(
    //         bottomLeft: const Radius.circular(10.0),
    //         bottomRight: const Radius.circular(10.0)),
    //     //make border radius more than 50% of square height & width
    //     child: Image(
    //         image: FileImage(foto ?? "assets/images/no-image.png", scale: 0.5),
    //         width: double.infinity,
    //         height: 300.0),
    //   );
    // else
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0.0, 5.0)),
      ], borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(30.0),
            bottomRight: const Radius.circular(30.0)),
        //make border radius more than 50% of square height & width
        child: FutureBuilder<Image>(
          future: getImage(prodDataTemp.image_1), // async work
          builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return FadeInImage(
                  image: AssetImage(Constant.loader1),
                  placeholder: AssetImage(Constant.loader1),
                  height: 250.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              default:
                if (snapshot.hasError)
                  return new Image.asset(Constant.NoImage,
                      width: double.infinity, height: 300.0);
                else
                  return imgNew;
            }
          },
        ),
      ),
    );
  }
}
