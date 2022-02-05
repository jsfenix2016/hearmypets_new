import 'package:flutter/material.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';

class FondoCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            ColorPalette.principal,
            Color.fromRGBO(90, 70, 178, 1.0),
          ],
        ),
      ),
    );

    final circulo = Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(
          top: 90.0,
          left: 30.0,
          child: circulo,
        ),
        Positioned(
          top: -40.0,
          right: -30.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        Positioned(
          top: 120.0,
          right: 20.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          left: -20.0,
          child: circulo,
        ),
        Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              new Image.asset(
                "assets/images/iconPets.png",
                color: Colors.white,
                width: 100,
                height: 100,
              ),

              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              // Text(
              //   "Ingresa a la app",
              //   style: TextStyle(color: Colors.white, fontSize: 25.0),
              // ),
            ],
          ),
        )
      ],
    );
  }
}
