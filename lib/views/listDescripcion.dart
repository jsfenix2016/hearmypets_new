import 'package:flutter/material.dart';
import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/blocks/productos_block.dart';
import 'package:heartmypet/blocks/provider.dart';

class ListDescripcion extends StatefulWidget {
  ListDescripcion({this.productoCell});

  final ProductoModel productoCell;
  @override
  _ListDescripcionState createState() => _ListDescripcionState();
}

class _ListDescripcionState extends State<ListDescripcion> {
  ProductosBlock productosBloc;
  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }

    return SingleChildScrollView(
      child: new ListView(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(16.0),
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
                      // Text(
                      //   producto.especie == null?"":producto.especie,
                      //   textAlign: TextAlign.justify,
                      // ),
                      SizedBox(height: 15),
                      Text(
                        "Genero de mascota:",
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      SizedBox(height: 10),
                      Text(
                        producto.genero == null ? "" : producto.genero,
                        textAlign: TextAlign.justify,
                      ),

                      SizedBox(height: 15),
                      // Text(
                      //   "Edad:",
                      //   textAlign: TextAlign.justify,
                      //   style: TextStyle(color: Colors.black, fontSize: 16.0),
                      // ),
                      SizedBox(height: 10),
                      Text(
                        "0",
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
