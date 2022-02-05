import 'package:flutter/material.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';

import 'package:heartmypet/Model/producto_model.dart';

import 'package:heartmypet/blocks/productos_block.dart';
import 'package:heartmypet/blocks/provider.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
import 'package:heartmypet/views/Home/homeCell.dart';

class MisMacotas extends StatelessWidget {
  final ProductoModel producto = new ProductoModel();

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final productosBlock = Provider.productosBloc(context);
    producto.idUser = 50; //prefs.idUser;

    productosBlock.loadMyPets(producto);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.principal,
        title: Text("listado de mis mascotas"),
      ),
      backgroundColor: Colors.white,
      body: _createListado(productosBlock),
      floatingActionButton: _createBottom(context),
    );
  }

  Widget _createListado(ProductosBlock productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) {
              return _crearItem(context, productosBloc, productos[i]);
            },
          );
        } else {
          return Center(
            child: new Image.asset("assets/images/loader2.gif"),
          );
        }
      },
    );
  }

  Widget cardTitleList(BuildContext context, ProductoModel producto) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(producto.image_1),
            placeholder: AssetImage("assets/images/jar-loading.gif"),
            height: 50.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text("${producto.namePet} - "),
            subtitle: Text(producto.description),
            onTap: () {
              // Navigator.pushNamed(context, "addProduct");
              Navigator.pushNamed(context, "addProduct", arguments: producto);
            },
          ),
        ],
      ),
    );
  }

  Widget _crearItem(BuildContext context, ProductosBlock productosBloc,
      ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        // productosBloc.borrarProducto(producto.id);
      },
      child: GestureDetector(
        // When the child is tapped, show a snackbar.
        onTap: () {
          // Navigator.pushNamed(context, "addProduct");
          Navigator.pushNamed(context, "addProduct", arguments: producto);
          // final snackBar = SnackBar(content: Text("Tap"));

          // Scaffold.of(context).showSnackBar(snackBar);
        },
        // The custom button
        child: Container(
          color: Colors.transparent,
          child: HomeCell(producto),
        ),
      ),
    );
  }

  _createBottom(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: ColorPalette.principal,
      onPressed: () {
        //createPlantFoodNotification();
        Navigator.pushNamed(context, "addProduct", arguments: producto);
      },
    );
  }
}
