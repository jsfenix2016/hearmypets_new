import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:heartmypet/Constant/Constant.dart';
import 'package:heartmypet/Model/user_model.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
import 'package:http/http.dart' as http;

//import 'package:heartmypet/utils/ManagerSecurity.dart';

class UsuarioProvider {
  final _prefs = new PreferenciasUsuario();

  //final encrip = new ManagerSecurity();
  Future<Map<String, dynamic>> loginMiApi(String email, String password) async {
    final authData = {"email": email, "pass": (password)};

    await _prefs.initPrefs();
    try {
      final resp = await http.post(Uri.parse(Constant.baseApi + "/Login"),
          body: json.encode(authData));

      Map<String, dynamic> decodeResp = json.decode(resp.body);

      print(decodeResp);
      if (decodeResp['id'] == null) {
        return {"ok": false, "mesaje": "error"};
      }
      var reslt = decodeResp['id'];

      print(reslt);
      if (decodeResp['id'] != null) {
        _prefs.idUser = decodeResp['id'];
        return {"ok": true, "token": decodeResp['id']};
      } else {
        return {"ok": false, "mesaje": decodeResp['id']};
      }
    } catch (error) {
      print(error.toString());
      return {"ko": false, "mesaje": error.toString()};
    }
  }

  Future<UserModel> consultUser() async {
    final authData = {"idUser": _prefs.idUser};

    final resp = await http.post(Uri.parse(Constant.baseApi + "/consultUser"),
        body: json.encode(authData));

    var decodeResp = json.decode(resp.body);

    var user = UserModel.fromJson(decodeResp[0]);

    print(user);
    return user;
  }

//FUNCIONA CORRECTAMENTE
  Future<Map<String, dynamic>> insertRegister(
      String email, String password, bool terms) async {
    String imageDir = "";

    // final urlImg = await subirImagen(image, user);

    // if (urlImg["ok"]) {
    //   imgDir = urlImg["imageUrl"];
    // }

    final authData = {
      "email": email,
      "pass": (password),
      //"pass": await ManagerSecurity().encrypte(password),
      "terms": terms
    };

    final resp = await http.post(Uri.parse(Constant.baseApi + "/registro"),
        body: json.encode(authData));

    var decodeResp = json.decode(resp.body);

    var reslt = decodeResp;

    if (reslt != null) {
      _prefs.idUser = decodeResp;

      final algomas = {"ok": true, "token": decodeResp};
      return algomas;
    } else {
      return {"ok": false, "mesaje": decodeResp["error"]["message"]};
    }
  }

  Future<UserModel> searchUser(int id) async {
    final authData = {"idUser": id};

    final resp = await http.post(Uri.parse(Constant.baseApi + "/consultUser"),
        body: json.encode(authData));

    var decodeResp = json.decode(resp.body);

    var reslt = decodeResp;
    final prodtemp = UserModel.fromJson(decodeResp);
    if (reslt != null) {
      _prefs.idUser = decodeResp;

      // final algomas = {"ok": true, "token": decodeResp};
      return prodtemp;
    } else {
      return prodtemp;
    }
  }

//FUNCIONA CORRECTAMENTE
  Future<Map<String, dynamic>> subirImagen(File image, String user) async {
    final bytes = image.readAsBytesSync();

    String img64 = base64Encode(bytes);

    final authData = {"image": img64, "user": user, "idUser": 50};

    final resp = await http.post(Uri.parse(Constant.baseApi + "/imageSa"),
        body: json.encode(authData));

    var decodeResp = json.decode(resp.body);

    var reslt = decodeResp;

    if (reslt[0]["image_1"] != null) {
      final algomas = {"ok": true, "imageUrl": reslt[0]["image_1"]};
      return algomas;
    } else {
      return {"ok": false, "mesaje": "no existe"};
    }
  }

  Future<Uint8List> buscarImagen(String imgUrl) async {
    final resp = await http
        .get(Uri.parse(Constant.baseApi + "/imageSa?imgName=$imgUrl"));

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print("Algo salio mal");
      print(resp.body);
      return null;
    }

    print(resp.body);

    Uint8List _bytesImage;

    _bytesImage = Base64Decoder().convert(resp.body);

    return _bytesImage;
  }

  Future<Image> buscarWEBImagen(String imgUrl) async {
    final resp = await http
        .get(Uri.parse(Constant.baseApi + "/imageWeb?imgName=$imgUrl"));

    print(resp.body);

    return Image.network(resp.body);
  }

  Future<int> deleteUser(int id) async {
    final url = "";
    final resp = await http.delete(Uri.parse(url));
    print(json.decode(resp.body));

    return 1;
  }
}
