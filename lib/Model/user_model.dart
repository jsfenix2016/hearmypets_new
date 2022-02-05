
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
   
    int idUser;
    String email;
    String nombre;
    bool premium;
    String apellido;
    String image_1;
    String image_2;
    String image_3;
    String localizacion;
    DateTime birthday;
    String gender;
    String descripcion;


    UserModel({
       
        this.idUser,
        this.email="",
        this.nombre = "",
        this.premium = false,
        this.apellido = "",
        this.image_1 = "",
        this.image_2 = "",
        this.image_3 = "",
        this.localizacion = "",
        this.birthday,
        this.gender = "",
        this.descripcion = ""  
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        
        idUser: json["id"],
        email: json["email"],
        nombre: json["nombre"],
        premium: json["premium"],
        apellido: json["apellido"],
        image_1: json["image_1"],
        image_2: json["image_2"],
        image_3: json["image_3"],
        localizacion: json["localizacion"],
        birthday: json["birthday"],
        gender: json["gender"],
        descripcion: json["description"]
    );

    Map<String, dynamic> toJson() => {
        "id": idUser,
        "email": email,
        "nombre": nombre,
        "premium": premium,
        "apellido": apellido,
        "image_1": image_1,
        "image_2": image_2,
         "image_3": image_3,
         "localizacion": localizacion,
         "birthday":birthday,
         "gender": gender,
         "descripcion": descripcion
    };
}
