import 'package:flutter/material.dart';
import 'package:heartmypet/Constant/Constant.dart';
import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/utils/utils.dart';

class HomeCell extends StatefulWidget {
  HomeCell(this.productoCell);
  final ProductoModel productoCell;
  @override
  _HomeCellState createState() => _HomeCellState();
}

class _HomeCellState extends State<HomeCell> {
  //ProductoModel producto = new ProductoModel();

  Image imgNew;
  final usuarioProvider = new UsuarioProvider();
  Future<Image> getImage(String urlImage) async {
    return imgNew = new Image.memory(
        await usuarioProvider.buscarImagen(urlImage),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250.0);
  }

  Widget get dogCard {
    // A new container
    // The height and width are arbitrary numbers for styling.
    return Container(
      width: 250.0,
      height: 115.0,
      child: Card(
        color: Colors.white,
        // Wrap children in a Padding widget in order to give padding.
        child: Padding(
          // The class that controls padding is called 'EdgeInsets'
          // The EdgeInsets.only constructor is used to set
          // padding explicitly to each side of the child.
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 64.0,
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
              Row(
                children: [
                  Text('Nombre: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  Text(widget.productoCell.namePet,
                      // Themes are set in the MaterialApp widget at the root of your app.
                      // They have default values -- which we're using because we didn't set our own.
                      // They're great for having consistent, app-wide styling that's easily changed.
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w300)),
                ],
              ),
              Text(
                  widget.productoCell.description == "null"
                      ? ""
                      : widget.productoCell.description,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300)),
              // Expanded(
              //   child: Row(
              //     children: <Widget>[
              //       IconButton(
              //         icon: Icon(Icons.star_border),
              //         onPressed: () {
              //           setState(() {});
              //         },
              //       ),
              //       IconButton(
              //         icon: Icon(Icons.favorite),
              //         onPressed: () {
              //           setState(() {});
              //         },
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get dogImageHolder {
    return Container(
      // You can explicitly set heights and widths on Containers.
      // Otherwise they take up as much space as their children.
      width: 100.0,
      height: 100.0,
      // Decoration is a property that lets you style the container.
      // It expects a BoxDecoration.
      decoration: BoxDecoration(
        // BoxDecorations have many possible properties.
        // Using BoxShape with a background image is the
        // easiest way to make a circle cropped avatar style image.
        shape: BoxShape.circle,
        image: DecorationImage(
          // Just like CSS's `imagesize` property.
          fit: BoxFit.cover,
          // A NetworkImage widget is a widget that
          // takes a URL to an image.
          // ImageProviders (such as NetworkImage) are ideal
          // when your image needs to be loaded or can change.
          // Use the null check to avoid an error.
          image: new AssetImage("assets/images/loader1.gif"),
        ),
      ),
    );
  }

  Widget get dogImage {
    return Container(
      // You can explicitly set heights and widths on Containers.
      // Otherwise they take up as much space as their children.
      width: 100.0,
      height: 100.0,
      // Decoration is a property that lets you style the container.
      // It expects a BoxDecoration.
      decoration: BoxDecoration(
        // BoxDecorations have many possible properties.
        // Using BoxShape with a background image is the
        // easiest way to make a circle cropped avatar style image.
        shape: BoxShape.circle,
        image: DecorationImage(
          // Just like CSS's `imagesize` property.
          fit: BoxFit.cover,
          // A NetworkImage widget is a widget that
          // takes a URL to an image.
          // ImageProviders (such as NetworkImage) are ideal
          // when your image needs to be loaded or can change.
          // Use the null check to avoid an error.
          image: new AssetImage("assets/images/loader1.gif"),
        ),
      ),
    );
  }

  Widget _mostrarFoto() {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0.0, 1.0)),
      ], borderRadius: BorderRadius.circular(50), color: Colors.white),
      child: ClipRRect(
        borderRadius: BorderRadius.all(const Radius.circular(50.0)),
        //make border radius more than 50% of square height & width
        child: FutureBuilder<Image>(
          future: getImage(widget.productoCell.image_1), // async work
          builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return FadeInImage(
                  image: AssetImage(Constant.loader1),
                  placeholder: AssetImage(Constant.loader1),
                  height: 100.0,
                  width: 100,
                  fit: BoxFit.cover,
                );
              default:
                if (snapshot.hasError)
                  return new Image.asset(Constant.NoImage,
                      width: 100, height: 100.0);
                else
                  return imgNew;
            }
          },
        ),
      ),
    );
  }

  // Widget imageNet() {
  //   // return Image(image: AssetImage("assets/images/loader1.gif"));

  //   return FutureBuilder<Image>(
  //     initialData: new Image.asset(Constant.NoImage,
  //         width: double.infinity, height: 300.0),
  //     future: getImage(widget.productoCell.image_1), // async work
  //     builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.waiting:
  //           return FadeInImage(
  //             image: AssetImage(Constant.loader1),
  //             placeholder: AssetImage(Constant.loader1),
  //             height: 250.0,
  //             width: double.infinity,
  //             fit: BoxFit.cover,
  //           );
  //         default:
  //           if (snapshot.hasError)
  //             return new Image.asset(Constant.NoImage,
  //                 width: double.infinity, height: 300.0);
  //           else
  //             return FadeInImage(
  //               image: NetworkImage(widget.productoCell.image_1),
  //               placeholder: AssetImage("assets/images/loader1.gif"),
  //               height: 300.0,
  //               width: double.infinity,
  //               fit: BoxFit.cover,
  //             );
  //       }
  //     },
  //   );

  //   return (widget.productoCell.image_1 == null)
  //       ? Image(image: AssetImage("assets/images/no-image.png"))
  //       : FadeInImage(
  //           image: NetworkImage(widget.productoCell.image_1),
  //           placeholder: AssetImage("assets/images/loader1.gif"),
  //           height: 300.0,
  //           width: double.infinity,
  //           fit: BoxFit.cover,
  //         );
  // }

  Widget get dogFavorite {
    return Container(
      // You can explicitly set heights and widths on Containers.
      // Otherwise they take up as much space as their children.
      width: 50.0,
      height: 50.0,
      // Decoration is a property that lets you style the container.
      // It expects a BoxDecoration.
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const <Widget>[],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 80.0,
            child: dogCard,
          ),
          Positioned(top: 7.5, left: 25, child: _mostrarFoto()),
          // Positioned(top: 7.5, child: dogImage),
        ],
      ),
    );
  }
}
