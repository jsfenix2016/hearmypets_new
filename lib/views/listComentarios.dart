import 'package:flutter/material.dart';
import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/blocks/productos_block.dart';
import 'package:heartmypet/blocks/provider.dart';

class ListComentario extends StatefulWidget {
  ListComentario({this.productoCell});

  final ProductoModel productoCell;
  @override
  _ListComentarioState createState() => _ListComentarioState();
}

class _ListComentarioState extends State<ListComentario> {
  ProductosBlock productosBloc;
  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }
    // Widget _crearPais() {
    //   return TextFormField(
    //     initialValue: producto.localizacion,
    //     textCapitalization: TextCapitalization.sentences,
    //     //keyboardType: TextInputType.numberWithOptions(decimal: true),
    //     decoration: InputDecoration(
    //       labelText: "País",
    //     ),
    //     onSaved: (value) => producto.localizacion = value,
    //   );
    // }

    Widget _createListado(ProductosBlock productosBloc) {
      return StreamBuilder(
        stream: productosBloc.productosStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoModel>> snapshot) {
          if (snapshot.hasData) {
            final productos = snapshot.data;
            //return  producto.fotoUrl==null? Container(color: Colors.red, height: 10,):
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, i) {
                return Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Row(
                        children: <Widget>[
                          new Image.asset("assets/images/loader2.gif"),
                          Text(
                            "Demo",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "In order to make the DogCard appear, let's modify the _MyHomePageState build method in y si sigo escribiendo texto que pasa??=???",
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
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

    return _createListado(productosBloc);
  }
}
