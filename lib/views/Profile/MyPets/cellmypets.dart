import 'package:flutter/material.dart';
import 'package:heartmypet/Constant/Constant.dart';
import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/utils/utils.dart';

class CellMyPets extends StatelessWidget {
  CellMyPets(this.productoCell);
  Image imgNew;
  final usuarioProvider = new UsuarioProvider();
  final ProductoModel productoCell;

  bool like = false;
  Future<Image> getImage(String urlImage) async {
    return imgNew = new Image.memory(
        await usuarioProvider.buscarImagen(urlImage),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250.0);
  }

  @override
  Widget build(BuildContext context) {
    var children2 = [
      ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        //make border radius more than 50% of square height & width
        child: FutureBuilder<Image>(
          future: getImage(productoCell.image_1), // async work
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
      Positioned(
        bottom: 0.5,
        child: contentInfoPets(context),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
      child: new Container(
        color: Colors.transparent,
        width: 290.0,
        height: 320.0,
        child: Stack(
          children: children2,
        ),
      ),
    );
  }

  Widget contentInfoPets(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      width: size.width,
      height: 120.0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0, left: 30.0, right: 45.0),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Nombre: ' + productoCell.namePet,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text('Descripción: ' + productoCell.description,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300)),
                Text('Genero: ' + productoCell.genero,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300)),
                Text(
                    'Edad: ' +
                        calculateAge(DateTime.parse(productoCell.birthDate))
                            .toString(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
