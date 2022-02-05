import 'dart:convert';

import 'package:heartmypet/Constant/Constant.dart';
import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
import 'package:http/http.dart' as http;

class ProductosProvider {
  //final String _url = "https://prueba-4ffd6.firebaseio.com";

  final _prefs = new PreferenciasUsuario();

  // Future<bool> crearProducto(ProductoModel producto) async {
  //   producto.idUser = _prefs.idUser;
  //   final url = "$_url/productos.json?auth=${_prefs.token}";

  //   final resp = await http.post(url, body: productoModelToJson(producto));
  //   final decodedData = json.decode(resp.body);

  //   print(decodedData);

  //   return true;
  // }

  Future<Map<String, dynamic>> saveProductoMiApi(ProductoModel producto) async {
    //producto.idUser = _prefs.idUser;
    final url = Constant.baseApi + "/savePet";

    final resp =
        await http.post(Uri.parse(url), body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);

    var reslt = decodedData;
    //final prodtemp = ProductoModel.fromJson(decodedData);
    final algomas = {"ok": true, "token": decodedData};
    if (reslt != null) {
      _prefs.idUser = decodedData;
      print(decodedData);

      return algomas;
    } else {
      return algomas;
    }
  }

  Future<Map<String, dynamic>> likeProductoMiApi(ProductoModel producto) async {
    final url = Constant.baseApi + "/LikePet";

    final resp =
        await http.post(Uri.parse(url), body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);

    var reslt = decodedData;
    //final prodtemp = ProductoModel.fromJson(decodedData);
    final algomas = {"ok": true, "token": decodedData};
    if (reslt != null) {
      _prefs.idUser = decodedData;
      print(decodedData);

      return algomas;
    } else {
      return algomas;
    }
  }

  // ignore: non_constant_identifier_names
  Future<List<ProductoModel>> SearchMylikeApi(ProductoModel producto) async {
    final url = Constant.baseApi + "/LikePet";

    final resp =
        await http.post(Uri.parse(url), body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);

    var reslt = decodedData;
    final prodtemp = ProductoModel.fromJson(decodedData);
    //final algomas = {"ok": true, "token": decodedData};
    if (reslt != null) {
      _prefs.idUser = decodedData;
      print(decodedData);

      return prodtemp.list;
    } else {
      return prodtemp.list;
    }
  }

  Future<List<ProductoModel>> loadMyPets(ProductoModel producto) async {
    final url = Constant.baseApi + "/allMyPets";

    final resp =
        await http.post(Uri.parse(url), body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    final prodtemp = ProductoModel.fromJsonList(decodedData);
    print(prodtemp.list);
    return prodtemp.list;
  }

  Future<List<ProductoModel>> cargarPetsMiApi(ProductoModel producto) async {
    final url = Constant.baseApi + "/consultPet";

    final resp =
        await http.post(Uri.parse(url), body: productoModelToJson(producto));
    // final List parsed = json.decode(resp.body);
    // List<ProductoModel> responseModelList =
    //     new ProductoModel.fromJson(parsed).list;

    final decodedData = json.decode(resp.body);
    //final users =
    //    decodedData.jsonList((e) => ProductoModel.fromJsonList(e)).toList();
    //var reslt = decodedData;

    final prodtemp = ProductoModel.fromJsonList(decodedData);
    print(prodtemp.list);
    // final algomas = {"ok": true, "token": prodtemp.list};
    return prodtemp.list;
    // if (reslt != null) {
    //   _prefs.idUser = decodedData;
    //   print(decodedData);

    //   return algomas;
    // } else {
    //   return algomas;
    // }

    // var dicPets = {};
    // Map<String, dynamic> petsDic = {
    //   'idUser': 581,
    //   'name': 'muñeca',
    //   'fotoUrl': 'Grande',
    //   'descMascota': 'Grande y cariñoso',
    //   'genero': 'macho',
    // };
    // var genero = <String>[
    //   '581',
    //   'muñeca',
    //   'Grande',
    //   'Grande y cariñoso',
    //   'macho',
    // ];
    // final prodtemp = ProductoModel.fromJson(petsDic);
    // final List<ProductoModel> productos = [];
    // productos.add(prodtemp);
    // var decodeData = json.decode(genero);
    // final resp = await http.get(
    //     "http://localhost:8087/consultPets");

    // var decodeResp = json.decode(resp.body);

//     print(decodeResp);
// var reslt =  decodeResp[0];
// var id = reslt["id"];
// print(id);

    // final idUser = _prefs.idUser;
    // print(idUser);
    // final url = "$_url/productos.json?auth=${_prefs.token}";
    // final resp = await http.get(url);
    //  return productos;
    // var decodeData = json.decode(resp.body);
    // final List<ProductoModel> productos = new List();

    // if (decodeData == null) return [];

    // //si vence el token
    // if (decodeData["error"] != null) return [];
    // decodeData.forEach((id, prod) {
    //   print(prod);
    //   final prodtemp = ProductoModel.fromJson(prod);
    //   prodtemp.id = id;

    //   productos.add(prodtemp);
    // });
    // print(_prefs.idUser);
    // print(decodeData);
    // return productos;
  }

  // Future<List<ProductoModel>> cargarProductos() async {
  //   final idUser = _prefs.idUser;
  //   print(idUser);
  //   final url = "$_url/productos.json?auth=${_prefs.token}";
  //   final resp = await http.get(url);
  //   final Map<String, dynamic> decodeData = json.decode(resp.body);
  //   final List<ProductoModel> productos = new List();

  //   if (decodeData == null) return [];

  //   //si vence el token
  //   if (decodeData["error"] != null) return [];
  //   decodeData.forEach((id, prod) {
  //     print(prod);
  //     final prodtemp = ProductoModel.fromJson(prod);
  //     prodtemp.id = id;

  //     productos.add(prodtemp);
  //   });
  //   print(_prefs.idUser);
  //   print(decodeData);
  //   return productos;
  // }

  // Future<List<ProductoModel>> editarProducto(ProductoModel producto) async {
  //   final url = "$_url/productos/${producto.id}.json?auth=${_prefs.token}";
  //   final resp =
  //       await http.put(Uri.parse(url), body: productoModelToJson(producto));
  //   // final Map<String, dynamic> decodeData = json.decode(resp.body);
  //   final List<ProductoModel> productos = new List();

  //   final decodeData = json.decode(resp.body);

  //   // if (decodeData == null) return [];

  //   // decodeData.forEach((id, prod) {
  //   //   print(prod);
  //   //   final prodtemp = ProductoModel.fromJson(prod);
  //   //   prodtemp.id = id;

  //   //   productos.add(prodtemp);
  //   // });

  //   print(decodeData);
  //   return productos;
  // }

  // Future<int> borrarProducto(int id) async {
  //   final url = "$_url/productos/$id.json?auth=${_prefs.token}";
  //   final resp = await http.delete(Uri.parse(url));
  //   print(json.decode(resp.body));

  //   return 1;
  // }

  // Future<String> subirImagenesStorage(List<Asset> resultList) async {

  //   String urlString = "";
  //   StorageReference ref = FirebaseStorage.instance.ref();
  //   for (Asset asset in resultList) {
  //     final path = await asset.getByteData();

  //     final imageData = path.buffer.asUint8List();

  //     final nameImage = "${DateTime.now().microsecond.toString()}";
  //     final task =
  //         ref.child("/users/${_prefs.idUser}/$nameImage").putData(imageData);

  //     task.events.listen((StorageTaskEvent event) async {
  //       if (task.isComplete && task.isSuccessful) {
  //         final url = await event.snapshot.ref.getDownloadURL();
  //         print("file url: $url");
  //         urlString = url.toString();
  //         return urlString;
  //       }
  //        return urlString;
  //     });

  //     _tasks.add(task);
  //     return urlString;
  //   }
  //   return urlString;
  // }

  // Future<String> subirImagen(File image) async {
  //   final url = Uri.parse(
  //       "https://api.cloudinary.com/v1_1/dfzosaw94/image/upload?upload_preset=qxplrtxk");
  //   final mimeType = mime(image.path).split("/");

  //   final imgUploadRequest = http.MultipartRequest("POST", url);

  //   final file = await http.MultipartFile.fromPath("file", image.path,
  //       contentType: MediaType(mimeType[0], mimeType[1]));

  //   imgUploadRequest.files.add(file);

  //   final stremResponse = await imgUploadRequest.send();
  //   final resp = await http.Response.fromStream(stremResponse);

  //   if (resp.statusCode != 200 && resp.statusCode != 201) {
  //     print("Algo salio mal");
  //     print(resp.body);
  //     return null;
  //   }

  //   final respData = json.decode(resp.body);

  //   return respData["secure_url"];
  // }
}
