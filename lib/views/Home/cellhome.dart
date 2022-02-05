import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:heartmypet/Constant/Constant.dart';
//import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/utils/utils.dart';

class cellHome extends StatelessWidget {
  cellHome(this.productoCell);
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
      FutureBuilder<Image>(
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
      Positioned(
        bottom: 0.5,
        child: contentInfoPets(context),
      ),
    ];
    return Visibility(
      visible: productoCell.isAvailable,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Banner(
          message: "nuevo",
          location: BannerLocation.topEnd,
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: new Container(
              color: Colors.transparent,
              width: 290.0,
              height: 300.0,
              child: Card(
                color: Colors.transparent,
                elevation: 0.0,
                child: Stack(
                  children: children2,
                ),
              ),
            ),
          ),
        ),
      ),
      replacement: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: new Container(
          color: Colors.transparent,
          width: 290.0,
          height: 300.0,
          child: Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Stack(
              children: children2,
            ),
          ),
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
        // The class that controls padding is called 'EdgeInsets'
        // The EdgeInsets.only constructor is used to set
        // padding explicitly to each side of the child.
        padding: const EdgeInsets.only(bottom: 0.0, left: 30.0, right: 45.0),
        // Column is another layout widget -- like stack -- that
        // takes a list of widgets as children, and lays the
        // widgets out from top to bottom.
        child: Card(
          color: Colors.white.withOpacity(0.7),
          // Wrap children in a Padding widget in order to give padding.
          child: Padding(
            // The class that controls padding is called 'EdgeInsets'
            // The EdgeInsets.only constructor is used to set
            // padding explicitly to each side of the child.
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 20.0,
              right: 20.0,
            ),
            // Column is another layout widget -- like stack -- that
            // takes a list of widgets as children, and lays the
            // widgets out from top to bottom.
            child: Column(
              // These alignment properties function exactly like
              // CSS flexbox properties.
              // The main axis of a column is the vertical axis,
              // `MainAxisAlignment.spaceAround` is equivalent of
              // CSS's 'justify-content: space-around' in a vertically
              // laid out flexbox.
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Nombre: ' + productoCell.namePet,
                    // Themes are set in the MaterialApp widget at the root of your app.
                    // They have default values -- which we're using because we didn't set our own.
                    // They're great for having consistent, app-wide styling that's easily changed.
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
                Expanded(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.star_border),
                        onPressed: () {
                          (context as Element).markNeedsBuild();
                        },
                      ),
                      SizedBox(width: 100),
                      IconButton(
                        iconSize: 30,
                        color: like == false ? Colors.black : Colors.red,
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          like = like == false ? true : false;
                          (context as Element).markNeedsBuild();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // imageNet(BuildContext context) async {
  //   // return Image(image: AssetImage("assets/images/loader1.gif"));
  //   imgNew = await getImage(productoCell.image_1);
  //   (context as Element).markNeedsBuild();
  // }

  // Widget dogImageHolder(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   return Container(
  //     // You can explicitly set heights and widths on Containers.
  //     // Otherwise they take up as much space as their children.
  //     width: size.width,
  //     height: 250.0,
  //     // Decoration is a property that lets you style the container.
  //     // It expects a BoxDecoration.
  //     child: HeroMode(
  //       child: Hero(tag: "tag", child: Container()),
  //       enabled: false,
  //     ),
  //     // decoration: BoxDecoration(
  //     //   borderRadius: BorderRadius.circular(10.0),
  //     //   // BoxDecorations have many possible properties.
  //     //   // Using BoxShape with a background image is the
  //     //   // easiest way to make a circle cropped avatar style image.
  //     //   shape: BoxShape.rectangle,
  //     //   image: DecorationImage(
  //     //     // Just like CSS's `imagesize` property.
  //     //     fit: BoxFit.cover,
  //     //     // A NetworkImage widget is a widget that
  //     //     // takes a URL to an image.
  //     //     // ImageProviders (such as NetworkImage) are ideal
  //     //     // when your image needs to be loaded or can change.
  //     //     // Use the null check to avoid an error.

  //     //     image: imgNew.image, // new AssetImage("assets/images/no-image.png"),
  //     //   ),
  //     // ),
  //   );
  // }
}
