import 'dart:io';

//import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:heartmypet/Model/user_model.dart';
import 'package:heartmypet/blocks/user_block.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/utils/DatePicker/DatePickerWidget.dart';
import 'package:heartmypet/utils/Location/locationCustomNew.dart';
import 'package:heartmypet/utils/datePickerCustom.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
//import 'package:heartmypet/utils/locationCustom.dart';
import 'package:heartmypet/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:heartmypet/blocks/provider.dart';
//import 'package:compressimage/compressimage.dart';
import 'package:heartmypet/utils/CustomDropdowButton.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';

//import 'package:geolocator/geolocator.dart';

class EditUserPage extends StatefulWidget {
  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pref = new PreferenciasUsuario();
  final ImagePicker _picker = ImagePicker();
  DateTime dateNew = DateTime.now();
  UserBlock userBloc;

  UserModel userModel = new UserModel();
  File foto;
  final usuarioProvider = new UsuarioProvider();

  bool _guardado = false;

  //bool _isVisible = false;
  bool isVisibleGenero = false;
  bool isVisibleTamano = false;
  bool isVisiblePedigree = false;
  String mascota;
  var listGeneric = <String>[];
  //List<Asset> resultList;

  var genero = <String>[
    'Macho',
    'Hembra',
  ];

  String generoText = "Cual es tu genero";
  String titleEnfermedad = "Padece enfermedad";
  String placeholderEdad = "Ingresa una edad";
  String titleEdad = "Edad";
  String tituloVista = "Perfil";
  String lblTituloDescripcion = "Mi descripción";
  String tituloDescripcionEnfermedad = "Descripción enfermedad";
  TimeOfDay selectedTime = TimeOfDay.now();
  //Position _currentPosition;

  var geolocator;
  //final _picker = ImagePicker();
  // String _currentAddress;
  @override
  Widget build(BuildContext context) {
    userBloc = Provider.userBloc(context);

    final UserModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      userModel = prodData;
      tituloVista = "Editar usuario";
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text(tituloVista)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {
              // getImageGallery();
              _procesarImagen(ImageSource.gallery);
            },
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              //_tomarFoto();
              _procesarImagen(ImageSource.camera);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                Column(
                  children: <Widget>[
                    _crearNombre(),
                    CustomDropdownButtonWidget(
                      isVisible: isVisibleGenero,
                      instance: genero,
                      mensaje:
                          userModel.gender == "" || userModel.gender == null
                              ? generoText
                              : userModel.gender,
                      onChanged: (String value) {
                        userModel.gender = value;
                        print(value);
                      },
                    ),
                    // _crearEdad(),
                    // LocationCustomWidget(
                    //   onChanged: (String value) {
                    //     print(value);
                    //     userModel.localizacion = value != '' ? value : '';
                    //   },
                    // ),
                    new LocationCuestomNew("Coloca tu dirección", true,
                        (String value) {
                      print(value);
                      userModel.localizacion = value != '' ? value : '';
                    }),

                    // new Datepickerwidget((DateTime value) {
                    //   print(value);
                    //   userModel.birthday = value;
                    //   calculateAge(value);
                    // }),
                    TextFormField(
                      initialValue: userModel.descripcion == null
                          ? ""
                          : userModel.descripcion,
                      onSaved: (value) => userModel.descripcion = value,
                      decoration: InputDecoration(
                        labelText: lblTituloDescripcion,
                      ),
                      maxLines: 5,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 20),
                    _crearBoton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: userModel.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Nombre",
      ),
      onSaved: (value) => userModel.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return "Ingresa un nombre";
        } else {
          return null;
        }
      },
    );
  }

  // Widget _crearEdad() {
  //   return TextFormField(
  //     initialValue: "",
  //     textCapitalization: TextCapitalization.sentences,
  //     keyboardType: TextInputType.number,
  //     decoration: InputDecoration(
  //       labelText: titleEdad,
  //     ),
  //     onSaved: (value) => calculateAge(userModel.birthday),
  //     validator: (value) {
  //       if (value.length > 1) {
  //         return placeholderEdad;
  //       } else {
  //         return "";
  //       }
  //     },
  //   );
  // }

  //capturar fotos usando la camara
  // Future getImage() async {
  //   final XFile image = await _picker.pickImage(
  //       source: ImageSource.camera, maxWidth: 300.0, maxHeight: 300.0);
  //   // var image = await ImagePicker.pickImage(
  //   //    source: ImageSource.camera, maxWidth: 300.0, maxHeight: 300.0);
  //   if (image == null) {
  //     return;
  //   }
  //   final File file = File(image.path);
  //   userModel.image_1 = null;
  //   setState(() {
  //     foto = file;
  //   });
  // }

//capturar imagen de la galeria de fotos
  // Future getImageGallery() async {
  //   final File file = await procesarImagen(ImageSource.gallery);
  //   // final XFile image = await _picker.pickImage(source: ImageSource.gallery);
  //   //var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   if (file == null) {
  //     return;
  //   }
  //   // final File file = File(image.path);
  //   userModel.image_1 = null;
  //   // print("FILE SIZE BEFORE: " + image.lengthSync().toString());
  //   // await CompressImage.compress(
  //   //     imageSrc: image.path,
  //   //     desiredQuality: 80); //desiredQuality ranges from 0 to 100
  //   // print("FILE SIZE  AFTER: " + image.toString());

  //   setState(() {
  //     foto = file;
  //   });
  // }

  _procesarImagen(ImageSource origen) async {
    //var file = await procesarImagen(origen);
    final File file = await procesarImagen(origen);
    userModel.image_1 = null;

    setState(() {
      foto = file;
    });
  }

  Widget _mostrarFoto() {
    if (userModel.image_1 != null && userModel.image_1 != "") {
      return FadeInImage(
        image: new NetworkImage(userModel.image_1),
        placeholder: new AssetImage("assets/images/no-image.png"),
        height: 200.0,
        width: double.infinity,
        fit: BoxFit.fill,
      );
    }
    if (foto != null)
      return Image(
          image: FileImage(foto ?? "assets/images/no-image.png", scale: 0.5),
          width: double.infinity,
          height: 300.0);
    else
      return Hero(
        child: new Image.asset("assets/images/no-image.png",
            width: double.infinity, height: 300.0),
        tag: "imagen",
      );
  }

  // Widget _crearPais() {
  //   return TextFormField(
  //     initialValue: userModel.localizacion,
  //     textCapitalization: TextCapitalization.sentences,
  //     //keyboardType: TextInputType.numberWithOptions(decimal: true),
  //     decoration: InputDecoration(
  //       labelText: "País",
  //     ),
  //     onSaved: (value) => userModel.localizacion = value,
  //   );
  // }

  // Widget _crearPais2() {
  //   return TextFormField(
  //     initialValue: userModel.localizacion,
  //     textCapitalization: TextCapitalization.sentences,
  //     //keyboardType: TextInputType.numberWithOptions(decimal: true),
  //     decoration: InputDecoration(
  //       labelText: "País",
  //     ),
  //     onSaved: (value) => userModel.localizacion = value,
  //   );
  // }

  Widget _crearBoton() {
    //  final ButtonStyle style =
    //     ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    //  ElevatedButton(
    //         style: style,
    //         onPressed: (_guardado) ? null : _submit,
    //         child: const Text('Guardar'),
    //       ),

    return ElevatedButton.icon(
      label: Text(
        "Guardar",
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
      icon: Icon(Icons.save),
      onPressed: (_guardado) ? null : _submit,
    );

    // return RaisedButton.icon(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(20.0),
    //   ),
    //   color: ColorPalette.principal,
    //   textColor: Colors.white,
    //   label: Text("Guardar", style:TextStyle(fontSize: 12, color: Colors.white) ,),
    //   icon: Icon(Icons.save),
    //   onPressed: (_guardado) ? null : _submit,
    // );
  }

  // Widget _crearDisponible() {
  //   return SwitchListTile(
  //     value: producto.disponible == null ? false : producto.disponible,
  //     title: Text("Disponible"),
  //     activeColor: ColorPalette.principal,
  //     onChanged: (value) => setState(() {
  //       producto.disponible = value;
  //     }),
  //   );
  // }

  // Widget _crearPedigree() {
  //   return SwitchListTile(
  //     value: producto.pedigree == null ? false : producto.pedigree,
  //     title: Text("Pedigree"),
  //     activeColor: ColorPalette.principal,
  //     onChanged: (value) => setState(() {
  //       producto.pedigree = value;
  //     }),
  //   );
  // }

// Widget _addAstrayed() {
//     return SwitchListTile(
//       value: producto.istrayed == null ? false : producto.istrayed,
//       title: Text("¿Esta extraviado?"),
//       activeColor: ColorPalette.principal,
//       onChanged: (value) => setState(() {
//         producto.istrayed = value;
//       }),
//     );
//   }

  // Widget _padeceEnfermedad() {
  //   return SwitchListTile(
  //     value: producto.enfermedad == null ? false : producto.enfermedad,
  //     title: Text(titleEnfermedad),
  //     activeColor: ColorPalette.principal,
  //     onChanged: (value) => setState(() {
  //       producto.enfermedad = value;
  //     }),
  //   );
  // }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _guardado = true;
    });

    userModel.idUser = 50; //pref.idUser;
    //if (foto != null) {
    //final nameImage = "${DateTime.now().microsecond.toString()}";
    // final urlImg = await _uploadFile(foto, nameImage);
    //  producto.fotoUrl = await productosBloc.subirFoto(foto);
    //}
    String imgDir = "";
    if (foto != null) {
      print(DateTime.now());
      // final nameImage = "${DateTime.now().microsecond.toString()}";
      final urlImg = await usuarioProvider.subirImagen(
          foto, DateTime.now().microsecond.toString());
      print(urlImg);

      if (urlImg["ok"]) {
        imgDir = urlImg["imageUrl"];
        userModel.image_1 = imgDir;
      }
    }

    //if (producto.id == null) {
    userBloc.editUser(userModel);
    //}
    // else {
    //   productosBloc.editarProducto(producto);
    // }

    mostrarSnackbar("Registro guardado");
    //Navigator.pop(context);
  }

  Future getMultiImage1() async {
    // String error;

    // try {
    //    resultList = await MultiImagePicker.pickImages(
    //     maxImages: 4,
    //   );

    // final  List<StorageUploadTask> _tasks = List();
    // final  StorageReference ref = FirebaseStorage.instance.ref();

    // final _prefs = new PreferenciasUsuario();
    //   String urlString = "";

    // for (Asset asset in resultList) {
    //   final path = await asset.getByteData();

    //   final imageData = path.buffer.asUint8List();

    //   final nameImage = "${DateTime.now().microsecond.toString()}";
    //   final task =
    //       ref.child("/users/${_prefs.idUser}/$nameImage").putData(imageData);

    //   task.events.listen((StorageTaskEvent event) async {
    //     if (task.isComplete && task.isSuccessful) {
    //       final url = await event.snapshot.ref.getDownloadURL();
    //       print("file url: $url");
    //       urlString = url.toString();

    //     }

    //   });

    //   _tasks.add(task);

    // }

    // } on Exception catch (e) {
    //   print(e);
    // }
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
