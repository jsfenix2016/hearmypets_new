import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:compressimage/compressimage.dart';

class ContentImageWidget extends StatefulWidget {
  ContentImageWidget({Key key, @required this.onChanged}) : super(key: key);
  final ValueChanged<File> onChanged;

  @override
  ContentImageWidgetClass createState() => new ContentImageWidgetClass();
}

class ContentImageWidgetClass extends State<ContentImageWidget> {
  File foto;
  final _picker = ImagePicker();
  Widget _mostrarFoto() {
    if (foto != null)
      return Image(
          image: FileImage(foto ?? "assets/images/no-image.png", scale: 0.5),
          width: double.infinity,
          height: 200.0);
    else
      return Hero(
        child: new Image.asset("assets/images/no-image.png",
            width: double.infinity, height: 300.0),
        tag: "imagen",
      );
  }

  Future getImageGallery() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    if (image == null) return;
    final File file = File(image.path);
    // var image =
    //     await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    if (file == null) {
      return;
    }
    //print("FILE SIZE BEFORE: " + image.lengthSync().toString());
    // await CompressImage.compress(
    //     imageSrc: image.path,
    //     desiredQuality: 80); //desiredQuality ranges from 0 to 100
    //  print("FILE SIZE  AFTER: " + image.lengthSync().toString());

    setState(() {
      foto = file;
      widget.onChanged(foto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        getImageGallery();
      },
      // The custom button
      child: Container(padding: EdgeInsets.all(0.0), child: _mostrarFoto()),
    );
  }
}
