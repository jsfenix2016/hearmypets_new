import 'package:heartmypet/provider/product_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:heartmypet/Model/producto_model.dart';

class ProductosBlock {
//<List<ProductoModel>>
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _myPrductController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _productosProvider = new ProductosProvider();

  Stream<List<ProductoModel>> get productosStream =>
      _productosController.stream;

  Stream<List<ProductoModel>> get myProductStream => _myPrductController.stream;

  Stream<bool> get cargando => _cargandoController.stream;

  void cargarProductos(ProductoModel producto) async {
    final productos = await _productosProvider.cargarPetsMiApi(producto);
    _productosController.sink.add(productos);
  }

  void loadMyPets(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    final productos = await _productosProvider.loadMyPets(producto);
    _myPrductController.sink.add(productos);
    _cargandoController.sink.add(false);
  }

  void agregarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.saveProductoMiApi(producto);
    _cargandoController.sink.add(false);
  }

  void likeProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.likeProductoMiApi(producto);
    _cargandoController.sink.add(false);
  }

  // void editarProducto(ProductoModel producto) async {
  //   _cargandoController.sink.add(true);
  //   await _productosProvider.editarProducto(producto);
  //   _cargandoController.sink.add(false);
  // }

  // void borrarProducto(int id) async {
  //   _cargandoController.sink.add(true);
  //   await _productosProvider.borrarProducto(id);
  //   _cargandoController.sink.add(false);
  // }

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

  dispose() {
    _productosController?.close();
    _cargandoController?.close();
    _myPrductController?.close();
  }
}
