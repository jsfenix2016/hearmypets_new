import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/blocks/productos_block.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/views/agregar_producto.dart';
import 'package:heartmypet/utils/utils.dart';

class AddController extends GetxController {
  ProductoModel producto = new ProductoModel();
  DateTime dateNew = DateTime.now();
  ProductosBlock productosBloc = new ProductosBlock();
  final usuarioProvider = new UsuarioProvider();
  File foto;
  AddPage view;

  submit(ProductoModel bloc, BuildContext context) async {
    //String imgDir = "";

    print(DateTime.now());
    //final nameImage = "${DateTime.now().microsecond.toString()}";
    // final urlImg = await usuarioProvider.subirImagen(
    //     foto, DateTime.now().microsecond.toString());
    // print(urlImg);

    // if (urlImg["ok"]) {
    //   imgDir = urlImg["imageUrl"];
    // bloc.fotoUrl = "imgDir";
    // }

    //final info = productosBloc.agregarProducto(bloc);

    mostrarAlerta(context, "agregado correctamente :D");
  }

  // void mostrarSnackbar(String mensaje, BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(mensaje),
  //       duration: Duration(milliseconds: 1500),
  //     ),
  //   );
  // }
}
