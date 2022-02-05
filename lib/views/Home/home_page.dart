import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heartmypet/Constant/Constant.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:heartmypet/Controllers/home_controller.dart';

import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/blocks/productos_block.dart';
import 'package:heartmypet/blocks/provider.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
import 'package:heartmypet/utils/widgets/Menu/MenuDrawable.dart';
import 'package:get/get.dart';
import 'cellhome.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductoModel producto = new ProductoModel();

  final prefs = new PreferenciasUsuario();

  final home_controller lc = Get.put(home_controller());

  @override
  void initState() {
    super.initState();
    prefs.initPrefs();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );

    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
                  AwesomeNotifications().setGlobalBadgeCounter(value - 1),
            );
      }
      Navigator.pushNamed(context, "miUser");
    });
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    // prefs.initPrefs();
    final productosBlock = Provider.productosBloc(context);
    producto.idUser = prefs.idUser;
    // // producto.namePet = "lilotry";
    // // producto.description = "bueno";
    // // producto.idRace = 1;
    // // producto.birthDate = ("2021-04-05");

    // // producto.isAvailable = true;
    // // producto.idPettype = 1;
    // //producto.tamano = "pequeño";
    // // producto.genero = "macho";
    // // producto.image_1 = "productoURL";
    // // producto.isTrayed = true;
    // // producto.enfermedad = false;
    // // producto.pedigree = true;
    // // if (_count == 0) {
    // //   _count = 1;
    productosBlock.cargarProductos(producto);
    // }

    // usuarioProvider.consultUser();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.principal,
        title: Text("listado de mascotas"),
      ),
      backgroundColor: Colors.white,
      body: _createListado(productosBlock),
      drawer: new CustomMenu(),
      // floatingActionButton: _createBottom(context),
    );
  }

  Widget _createListado(ProductosBlock productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: productos.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                child: cellHome(productos[i]),
                onTap: () {
                  Navigator.pushNamed(context, "preview",
                      arguments: productos[i]);
                },
              );
            },
          );
        } else {
          return Center(
            child: new Image.asset(Constant.imageLoader2),
          );
        }
      },
    );
  }

  // Widget cardTitleList(BuildContext context, ProductoModel producto) {
  //   return Card(
  //     child: Column(
  //       children: <Widget>[
  //         FadeInImage(
  //           image: NetworkImage(producto.image_1),
  //           placeholder: AssetImage(Constant.imagLoader1),
  //           height: 50.0,
  //           width: double.infinity,
  //           fit: BoxFit.cover,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _createBottom(BuildContext context) {
  //   return FloatingActionButton(
  //     child: Icon(Icons.add),
  //     backgroundColor: ColorPalette.principal,
  //     onPressed: () {
  //       //createPlantFoodNotification();
  //       Navigator.pushNamed(context, "miUser");
  //     },
  //   );
  // }
}
