import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartmypet/Model/producto_model.dart';
//import 'package:heartmypet/blocks/login_bloc.dart';
//import 'package:heartmypet/blocks/productos_block.dart';
//import 'package:heartmypet/blocks/provider.dart';
import 'package:heartmypet/provider/product_provider.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
//import 'package:heartmypet/utils/utils.dart';

// ignore: camel_case_types
class home_controller extends GetxController {
  final usuarioProvider = new UsuarioProvider();
  final productosBlock = new ProductosProvider();
  final List<ProductoModel> files = [];

  //Future<Image> searchImage(ProductoModel producto) async {
  // print("urlImage:${producto.image_1}");
  // Image img;
  // print("==========");
  // try {
  //  // img = await usuarioProvider.buscarImagen(producto.image_1);
  //  // if (img == null) {
  //     // Navigator.pushReplacementNamed(context, "home");

  //   //  return img;
  //  // } else {
  //     // mostrarAlerta(context, "Ususario o password incorrecto".tr);
  //     return Image(image: AssetImage("assets/images/no-image.png"));
  //   }
  // } catch (error) {
  //   print(error.toString());
  //   return Image(image: AssetImage("assets/images/no-image.png"));
  // }
  //}

  // Future<List<ProductoModel>> getAllPets(
  //     ProductoModel producto, BuildContext context) async {
  //   // print("==========");
  //   // print("Email: ${bloc.email}");
  //   // print("Password:${bloc.password}");
  //   // print("==========");

  //   final files = await productosBlock.cargarPetsMiApi(producto);
  //   print(files);
  //   // return productosBlock;
  //   // try {
  //   //   Map info = await usuarioProvider.loginMiApi(bloc.email, bloc.password);
  //   //   if (info["ok"]) {
  //   //     Navigator.pushReplacementNamed(context, "home");
  //   //   } else {
  //   //     mostrarAlerta(context, "Ususario o password incorrecto".tr);
  //   //   }
  //   // } catch (error) {
  //   //   print(error.toString());
  //   // }
  // }

  like() {}

  logOut(BuildContext context) {}

  goToRegister(BuildContext context) {
    Navigator.pushReplacementNamed(context, "registro");
  }
}
