//import 'dart:io';

import 'package:heartmypet/Model/user_model.dart';

import 'package:heartmypet/provider/usuario_provider.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:rxdart/subjects.dart';

class UserBlock {
//<List<ProductoModel>>
  final _userController = new BehaviorSubject<UserModel>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _userProvider = new UsuarioProvider();

  Stream<UserModel> get productosStream => _userController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarUser(int id) async {
    final productos = await _userProvider.searchUser(id);
    _userController.sink.add(productos);
  }

  void editUser(UserModel user) async {
    _cargandoController.sink.add(true);
    await _userProvider.searchUser(user.idUser);
    // await _productosProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  // Future<String> subirFoto(File foto) async {
  //   // _cargandoController.sink.add(true);
  //   // final fotoUrl = await _productosProvider.subirImagen(foto);
  //   // _cargandoController.sink.add(false);

  //   return "https://i.ytimg.com/vi/xWuQ6k3_Yns/hqdefault.jpg";
  // }

  // Future<String> subirFotoStorge(List<Asset> resultList) async {
  //   _cargandoController.sink.add(true);
  //   final fotoUrl = await _productosProvider.subirImagenesStorage(resultList);
  //   _cargandoController.sink.add(false);

  //   return fotoUrl;
  // }

  void editarProducto(UserModel producto) async {
    _cargandoController.sink.add(true);
    //  await _userProvider.editarUser(producto);
    _cargandoController.sink.add(false);
  }

  void borrarProducto(int id) async {
    _cargandoController.sink.add(true);
    await _userProvider.deleteUser(id);
    _cargandoController.sink.add(false);
  }

  dispose() {
    _userController?.close();
    _cargandoController?.close();
  }
}
