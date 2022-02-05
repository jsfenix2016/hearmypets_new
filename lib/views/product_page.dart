import 'package:flutter/material.dart';
import 'package:heartmypet/Constant/Constant.dart';
import 'package:heartmypet/Model/producto_model.dart';

import 'package:heartmypet/blocks/productos_block.dart';
import 'package:heartmypet/blocks/provider.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/utils/utils.dart';

//import 'package:heartmypet/views/listComentarios.dart';
//import 'package:heartmypet/views/listDescripcion.dart';

import 'package:uuid/uuid.dart';

var uuid = new Uuid();

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => new _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductosBlock productosBloc;

  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // backgroundColor: Colors.red,
      body: new SilverAppBarWithTabBarScreen(),
    );
  }
}

class SilverAppBarWithTabBarScreen extends StatefulWidget {
  @override
  _SilverAppBarWithTabBarState createState() => _SilverAppBarWithTabBarState();
}

class _SilverAppBarWithTabBarState extends State<SilverAppBarWithTabBarScreen>
    with SingleTickerProviderStateMixin {
  //TabController controller;

  ProductosBlock productosBloc;
  ProductoModel producto = new ProductoModel();
  Image imgNew;
  String raza;
  final usuarioProvider = new UsuarioProvider();
  // List<Widget> tabs = [
  //  new ListDescripcion(),

  // // new ListComentario(),
  // ];
  Future<Image> getImage(String urlImage) async {
    return imgNew = new Image.memory(
        await usuarioProvider.buscarImagen(urlImage),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250.0);
  }

  @override
  void initState() {
    super.initState();
    // controller = new TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;

      raza = prodData.idPettype == 1
          ? Constant.perrosRazas[prodData.idPettype]
          : Constant.gatosRazas[prodData.idPettype];
    }

    return Scaffold(
      body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  expandedHeight: 300.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(prodData.namePet,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: new FutureBuilder<Image>(
                      future: getImage(prodData.image_1), // async work
                      builder: (BuildContext context,
                          AsyncSnapshot<Image> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return FadeInImage(
                              image: AssetImage("assets/images/loader2.gif"),
                              placeholder:
                                  AssetImage("assets/images/loader2.gif"),
                              height: 300.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          default:
                            if (snapshot.hasError)
                              return new Image.asset(
                                  "assets/images/no-image.png",
                                  width: double.infinity,
                                  height: 300.0);
                            else
                              return imgNew;
                        }
                      },
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Card(
            margin: const EdgeInsets.only(top: 100, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Descripción:",
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      SizedBox(height: 10),
                      Text(
                        producto.description == null
                            ? ""
                            : producto.description,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Tipo de mascota:",
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: raza != null ? true : false,
                        child: Text(
                          "Raza: " + raza,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Genero: ' + producto.genero,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Edad: ' +
                            calculateAge(DateTime.parse(producto.birthDate))
                                .toString(),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        color: Colors.amber,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.star_border),
                              onPressed: () {
                                (context as Element).markNeedsBuild();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite),
                              onPressed: () {
                                (context as Element).markNeedsBuild();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
