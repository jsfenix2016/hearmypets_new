import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  int idPet;
  int idUser;
  String namePet;
  String birthDate;
  int idRace;
  String image_1;
  String image_2;
  String image_3;
  String image_4;
  int idPettype;
  String description;

  bool isAvailable;
  String genero;
  bool isTrayed;
  int idSize;
  List<ProductoModel> list;

  ProductoModel(
      {this.idPet,
      this.idUser,
      this.namePet,
      this.birthDate,
      this.idRace,
      this.image_1,
      this.image_2,
      this.image_3,
      this.image_4,
      this.idPettype,
      this.description,
      this.isAvailable,
      this.genero,
      this.isTrayed,
      this.idSize,
      this.list});

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        idPet: json["idPet"],
        idUser: json["idUser"],
        namePet: json["name"],
        birthDate: json["birthDate"],
        idRace: json["idRace"],
        image_1: json["image_1"],
        image_2: json['image_2'],
        image_3: json['image_3'],
        image_4: json['image_4'],
        idPettype: json["idPettype"],
        description: json["description"],
        isAvailable: json["isAvailable"] == 1 ? true : false,
        genero: json["genero"],
        isTrayed: json["isTrayed"] == 1 ? true : false,
        idSize: json["IdSize"],
      );

  Map<String, dynamic> toJson() => {
        "idPet": idPet,
        "idUser": idUser,
        "name": namePet,
        "birthDate": birthDate,
        "idRace": idRace,
        'image_1': image_1,
        'image_2': image_2,
        'image_3': image_3,
        'image_4': image_4,
        "idPettype": idPettype,
        "description": description,
        "isAvailable": isAvailable,
        "genero": genero,
        "isTrayed": isTrayed,
        "idSize": idSize
      };

  List<dynamic> toJsonList() => [
        {
          "idPet": idPet,
          "idUser": idUser,
          "name": namePet,
          "birthDate": birthDate,
          "idRace": idRace,
          'image_1': image_1,
          'image_2': image_2,
          'image_3': image_3,
          'image_4': image_4,
          "idPettype": idPettype,
          "description": description,
          "isAvailable": isAvailable,
          "genero": genero,
          "isTrayed": isTrayed,
          "idSize": idSize,
        }
      ];

  factory ProductoModel.fromJsonList(List<dynamic> parsedJson) {
    List<ProductoModel> list;
    list = parsedJson.map((i) => ProductoModel.fromJson(i)).toList();

    return new ProductoModel(list: list);
  }
}
