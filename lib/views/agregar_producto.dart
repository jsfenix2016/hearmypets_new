import 'dart:io';

import 'package:get/get.dart';
import 'package:heartmypet/Constant/Constant.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:heartmypet/Controllers/add_Controller.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/utils/DatePicker/DatePickerWidget.dart';
import 'package:heartmypet/utils/Dropdown/DropDownButton.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
import 'package:heartmypet/utils/Location/locationCustomNew.dart';
import 'package:heartmypet/utils/SwitchListTileustom/SwitchListTileCustom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/blocks/productos_block.dart';
import 'package:heartmypet/blocks/provider.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pref = new PreferenciasUsuario();

  ProductosBlock productosBloc;
  AddController addVC = new AddController();
  ProductoModel producto = new ProductoModel();
  File foto;
  final usuarioProvider = new UsuarioProvider();

  bool _guardado = false;

  bool _isVisible = false;
  bool isVisibleGenero = false;
  bool isVisibleTamano = false;
  bool isVisiblePedigree = false;
  String mascota;
  String typePet;
  String raza;
  var listGeneric = Map<int, String>();
//List<Asset> resultList ;

  Map<int, String> perrosRazas = {
    0: 'Labrador retriever',
    1: 'Husky siberiano',
    2: 'Bulldog',
    3: 'Pug',
    4: 'Pomerania',
    5: 'Shiba Inu',
    6: 'Poodle',
    7: 'Golden retriever',
    8: 'Pit bukk terrier americano',
    9: 'Chihuahua',
    10: 'Pastor aleman',
    11: 'Beagle'
  };

  // var tamano = <String>[
  //   'Pequeño',
  //   'Mediano',
  //   'Grande',
  // ];

  Map<int, String> gatosRazas = {
    0: 'Gato persa',
    1: 'Bengala',
    2: 'Maine coon',
    3: 'Gato siamés',
    4: 'British Shorthair',
    5: 'Sphynx',
    6: 'Ragdoll',
    7: 'Azul ruso',
    8: 'Munchkin',
    9: 'Scottish flod',
    10: 'Savannah',
    11: 'Siberiano'
  };

  // var mascotasTipo = <String>[
  //   'Gato',
  //   'Perro',
  //   'Uron',
  //   'Araña',
  //   'Serpiente',
  //   'Tigre',
  //   'Mono',
  // ];

  //  Map<String, int> mascotasTipo = {
  //   'Gato': 0,
  //   'Perro': 1,
  //   'Uron': 2,
  //   'Araña': 3,
  //   'Serpiente': 4,
  //   'Tigre': 5,
  //   'Mono': 6,
  // };

  Map<int, String> mascotasTipoWithDictionary = {
    0: 'Gato',
    1: 'Perro',
    2: 'Uron',
    3: 'Araña',
    4: 'Serpiente',
    5: 'Tigre',
    6: 'Mono',
  };

  String tamano;

  Map<int, String> tamanoDic = {
    0: 'Pequeño',
    1: 'Mediano',
    2: 'Grande',
  };
  String gen;
  Map<int, String> genero = {
    0: 'Macho',
    1: 'Hembra',
  };

  //String raza = "Selecciona la raza de tu mascota";
  String tipo = 'Select_species'.tr;
  String tamanoText = "Tamaño de tu mascota";
  String generoText = 'gender'.tr;
  String titleEnfermedad = "Padece enfermedad";
  String placeholderEdad = "Ingresa una edad";
  String titleEdad = "Edad";
  String tituloVista = "Agrega tu mascota";
  String lblTituloDescripcion = "Descripción de mi mascota";
  String tituloDescripcionEnfermedad = "Descripción enfermedad";
  TimeOfDay selectedTime = TimeOfDay.now();
  //Position _currentPosition;
  //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final _picker = ImagePicker();
  bool istrayed;
  Image imgNew;
  Future<Image> getImage(String urlImage) async {
    return imgNew = new Image.memory(
        await usuarioProvider.buscarImagen(urlImage),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250.0);
  }

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);
    // Dropdown_controller cdrop = Get.put(Dropdown_controller());
    // cdrop.dicItems = mascotasTipoWithDictionary.obs;

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      producto = prodData;
      tituloVista = "Modificar mascota";
      typePet = mascotasTipoWithDictionary[producto.idPet];
      tamano = tamanoDic[producto.idSize];
      istrayed = producto.isTrayed;
      // if (producto.especie == "Perro") {
      //   listGeneric = perrosRazas;
      //   isVisibleGenero = true;
      //   isVisibleTamano = false;
      //   isVisiblePedigree = true;
      // }
      // if (producto.especie == "Gato") {
      //   listGeneric = gatosRazas;
      //   isVisibleGenero = true;
      //   isVisibleTamano = false;
      //   isVisiblePedigree = true;
      // }
    }

    return Scaffold(
      floatingActionButton: _createBottom(context),
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorPalette.principal,
        title: Center(child: Text(tituloVista)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {
              getImageGallery();
            },
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              _tomarFoto();
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
                    SizedBox(height: 10),
                    _crearNombre(producto.namePet),
                    // _crearPais(),
                    new CustomDropdownButton(
                        typePet == null ? 'Select_species'.tr : typePet,
                        true,
                        mascotasTipoWithDictionary, (String value) {
                      // producto.especie = mascotasTipoWithDictionary[value];
                      producto.idPettype = int.parse(value);

                      if (mascotasTipoWithDictionary[int.parse(value)] ==
                              "Perro" ||
                          mascotasTipoWithDictionary[int.parse(value)] ==
                              "Gato") {
                        _isVisible = true;
                      }

                      if (mascotasTipoWithDictionary[int.parse(value)] ==
                          "Perro") {
                        listGeneric = perrosRazas;
                        isVisibleGenero = true;
                        isVisiblePedigree = true;
                      } else if (mascotasTipoWithDictionary[int.parse(value)] ==
                          "Gato") {
                        listGeneric = gatosRazas;
                        isVisibleGenero = true;
                        isVisiblePedigree = true;
                      } else {
                        isVisiblePedigree = false;
                      }
                    }),
                    new CustomDropdownButton(
                        'Select_pets'.tr, _isVisible, listGeneric,
                        (String value) {
                      producto.idRace =
                          int.parse(value); //value; //listGeneric[value];
                      print(value);
                    }),
                    new CustomDropdownButton(
                        tamano == null ? 'select_size_pet'.tr : tamano,
                        true,
                        tamanoDic, (String value) {
                      //producto.tamano = tamanoDic[value];
                      print(value);
                    }),
                    new CustomDropdownButton(
                        producto.genero == null ? 'gender'.tr : producto.genero,
                        true,
                        genero, (String value) {
                      producto.genero = genero[value];
                      print(value);
                    }),

                    new SwitchListTileCustom(
                        "¿Disponible ?", producto.isAvailable, true,
                        (bool value) {
                      //value; //listGeneric[value];
                      print(value);

                      //  producto.isTrayed =  int.parse(value);
                    }),

                    new SwitchListTileCustom(
                        "¿Esta extraviado?", istrayed, true, (bool value) {
                      //value; //listGeneric[value];
                      print(value);
                      producto.isTrayed = istrayed = value;
                    }),
                    new SwitchListTileCustom(titleEnfermedad, _isVisible, true,
                        (bool value) {
                      //value; //listGeneric[value];
                      print(value);
                      //  producto.istrayed = value;
                    }),
                    // LocationCustomWidget(
                    //   onChanged: (String value) {
                    //     print(value);
                    //     producto.localizacion = value;
                    //   },
                    // ),
                    new LocationCuestomNew("Coloca tu dirección", true,
                        (String value) {
                      print(value);
                      // producto.localizacion = value;
                    }),
                    new Datepickerwidget(DateTime.parse(producto.birthDate),
                        (DateTime value) {
                      print(value);
                      // producto.fechaNacimiento = value;
                    }),

                    //_padeceEnfermedad(),

                    // Visibility(
                    //   visible: producto.enfermedad == null
                    //       ? false
                    //       : producto.enfermedad,
                    //   child: TextFormField(
                    //     initialValue: producto.descEnfermedad == null
                    //         ? ""
                    //         : producto.descEnfermedad,
                    //     onSaved: (value) => producto.descEnfermedad = value,
                    //     decoration: InputDecoration(
                    //       labelText: tituloDescripcionEnfermedad,
                    //     ),
                    //     maxLines: 5,
                    //     style: TextStyle(
                    //         color: Colors.black, fontWeight: FontWeight.w300),
                    //   ),
                    // ),
                    // Visibility(
                    //   visible: isVisiblePedigree,
                    //   child: _crearPedigree(),
                    // ),
                    TextFormField(
                      initialValue: producto.description == null
                          ? ""
                          : producto.description,
                      onSaved: (value) => producto.description = value,
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

  _createBottom(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.remove_red_eye_outlined),
      backgroundColor: ColorPalette.principal,
      onPressed: () {
        //createPlantFoodNotification();
        Navigator.pushNamed(context, "preview", arguments: producto);
      },
    );
  }

  Widget _crearNombre(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: TextFormField(
        initialValue: name,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: name,
          labelText: "Nombre",
        ),
        onSaved: (value) => name = value,
        validator: (value) {
          if (value.length < 3) {
            return "Ingresa un nombre";
          } else {
            return null;
          }
        },
      ),
    );
  }

  // Widget _crearEdad() {
  //   return TextFormField(
  //     initialValue: producto.edad == null ? "" : producto.edad.toString(),
  //     textCapitalization: TextCapitalization.sentences,
  //     keyboardType: TextInputType.number,
  //     decoration: InputDecoration(
  //       labelText: titleEdad,
  //     ),
  //     onSaved: (value) => producto.edad = double.parse(value),
  //     validator: (value) {
  //       if (value.length < 1) {
  //         return placeholderEdad;
  //       } else {
  //         return null;
  //       }
  //     },
  //   );
  //}

  //capturar fotos usando la camara
  // Future getImage() async {
  //   PickedFile image = await _picker.getImage(
  //       source: ImageSource.camera, maxWidth: 300.0, maxHeight: 300.0);
  //   final File file = File(image.path);
  //   // var image = await ImagePicker.pickImage(
  //   //    source: ImageSource.camera, maxWidth: 300.0, maxHeight: 300.0);

  //   //final File file = File(image.path);
  //   // var image = await ImagePicker.pickImage(
  //   //     source: ImageSource.camera, maxWidth: 300.0, maxHeight: 300.0);

  //   producto.image_1 = null;
  //   setState(() {
  //     foto = file;
  //   });
  // }

//capturar imagen de la galeria de fotos
  Future getImageGallery() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    final File file = File(image.path);
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    producto.image_1 = null;
    // print("FILE SIZE BEFORE: " + image.lengthSync().toString());
    // await CompressImage.compress(
    //     imageSrc: image.path,
    //     desiredQuality: 80); //desiredQuality ranges from 0 to 100
    //  print("FILE SIZE  AFTER: " + image.lengthSync().toString());

    setState(() {
      foto = file;
    });
  }

  _procesarImagen(ImageSource origen) async {
    PickedFile image = await _picker.getImage(source: origen);
    final File file = File(image.path);
    //File image = await ImagePicker.pickImage(source: origen);

    producto.image_1 = null;

    setState(() {
      foto = file;
    });
  }

  Widget _mostrarFoto() {
    if (producto.image_1 != null && producto.image_1 != "") {
      return FutureBuilder<Image>(
        future: getImage(producto.image_1), // async work
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
      );
    }
    if (foto != null)
      return Image(
          image: FileImage(foto ?? "assets/images/no-image.png", scale: 0.5),
          width: double.infinity,
          height: 300.0);
    else {
      // var a = buscarImagen("");
      // var a =
      //     "https://5db0a657b5d3.ngrok.io/imageSa?imgName=dir/ImageUser/50/589.png";
      // return new Image.asset(a, width: double.infinity, height: 200.0);
      //final urlImg = await usuarioProvider.buscarImagen("");
      return Hero(
        child: new Image.asset("assets/images/no-image.png",
            width: double.infinity, height: 200.0),
        tag: "imagen",
      );
    }
  }

  _tomarFoto() async {
    //mostrarSnackbar("Registro guardado", context);
    _procesarImagen(ImageSource.camera);
  }

  // _seleccionarFoto() async {
  //   _procesarImagen(ImageSource.gallery);
  // }

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

  // Widget _crearPais2() {
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

  Widget _crearBoton() {
    return ElevatedButton.icon(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorPalette.principal)),
      label: Text("Guardar"),
      icon: Icon(
        Icons.save,
      ),
      onPressed: (_guardado) ? null : _submit,
    );
  }

  // CheckboxWidgetClass(
  //                   "el titulo deberia ir aqui", true, TextDecoration.none,
  //                   (bool value) {
  //                 print(value);

  //               }),

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
  //   return SwitchListTile(
  //     value: producto.istrayed == null ? false : producto.istrayed,
  //     title: Text("¿Esta extraviado?"),
  //     activeColor: ColorPalette.principal,
  //     onChanged: (value) => setState(() {
  //       producto.istrayed = value;
  //     }),
  //   );
  // }

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
    //if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      // _guardado = true;
    });

    // producto.idUser = 50; //pref.idUser;
    // producto.name = "lilotry";
    // producto.descMascota = "bueno";
    // producto.idRaza = 1;

    // producto.disponible = true;
    // producto.idEspecie = 1;
    // producto.tamano = "pequeño";
    // producto.genero = "macho";
    // producto.fotoUrl = "productoURL";
    // producto.enfermedad = false;
    // producto.pedigree = true;

    addVC.submit(producto, context);
    //if (foto != null) {
    //final nameImage = "${DateTime.now().microsecond.toString()}";
    // final urlImg = await _uploadFile(foto, nameImage);
    //  producto.fotoUrl = await productosBloc.subirFoto(foto);
    //}
    // String imgDir = "";
    // if (foto != null) {
    //   final nameImage = "${DateTime.now().microsecond.toString()}";
    //   final urlImg = await usuarioProvider.subirImagen(
    //       foto, DateTime.now().microsecond.toString());
    //   print(urlImg);

    //   if (urlImg["ok"]) {
    //     imgDir = urlImg["imageUrl"];
    //     producto.fotoUrl = imgDir;
    //   }
    // }

    // productosBloc.agregarProducto(producto);

    // mostrarSnackbar("Registro guardado", context);
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

// Future<String> _uploadFile(File file, String filename) async {
//     StorageReference storageReference ;
//    final idUser = pref.idUser;
//       storageReference =
//         FirebaseStorage.instance.ref().child("users").child("$idUser/images/$filename");

//     final StorageUploadTask uploadTask = storageReference.putFile(file);
//     final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
//     final String url = (await downloadUrl.ref.getDownloadURL());
//     print("URL is $url");
//     return url;
//   }

  // void mostrarSnackbar(String mensaje, BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(mensaje),
  //       duration: Duration(milliseconds: 1500),
  //     ),
  //   );
  // }
}
