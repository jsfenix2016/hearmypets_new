//import 'dart:ffi';
//import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:heartmypet/Controllers/myLike_controller.dart';

import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/blocks/productos_block.dart';
import 'package:heartmypet/blocks/provider.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
import 'package:heartmypet/utils/widgets/Menu/MenuDrawable.dart';
import 'package:heartmypet/views/Home/cellhome.dart';
import 'package:get/get.dart';

class MyLikePage extends StatefulWidget {
  @override
  _MyLikePageState createState() => _MyLikePageState();
}

class _MyLikePageState extends State<MyLikePage> {
  final ProductoModel producto = new ProductoModel();

  final prefs = new PreferenciasUsuario();

  final myLike_controller lc = Get.put(myLike_controller());

  //int _count = 0;

  @override
  void initState() {
    super.initState();
    prefs.initPrefs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    final productosBlock = Provider.productosBloc(context);
    producto.idUser = prefs.idUser;
    // producto.namePet = "lilotry";
    // producto.description = "bueno";
    // producto.idRace = 1;
    // producto.birthDate = ("2021-04-05");

    // producto.isAvailable = true;
    // producto.idPettype = 1;
    // //producto.tamano = "pequeño";s
    // producto.genero = "macho";
    // producto.image_1 = "productoURL";
    // producto.isTrayed = true;
    // producto.enfermedad = false;
    // producto.pedigree = true;
    // if (_count == 0) {
    //   _count = 1;
    //productosBlock.cargarProductos(producto);
    // }
    lc.getAllPetsLike(producto, context);
    // usuarioProvider.consultUser();

    return Scaffold(
      appBar: AppBar(
        title: Text("listado de mascotas"),
      ),
      backgroundColor: Colors.white,
      body: _createListado(productosBlock),
      drawer: new CustomMenu(),
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
                  Navigator.pushNamed(context, "product",
                      arguments: productos[i]);
                },
              );
            },
          );
        } else {
          return Center(
            child: new Image.asset("assets/images/loader2.gif"),
          );
        }
      },
    );
  }

  Widget cardTitleList(BuildContext context, ProductoModel producto) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(producto.image_1),
            placeholder: AssetImage("assets/images/jar-loading.gif"),
            height: 50.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
