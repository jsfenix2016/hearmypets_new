import 'package:flutter/material.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:onboarding/onboarding.dart';

class OnboardingPage extends StatelessWidget {
  final onboardingPagesList = [
    PageModel(
      widget: Column(
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 45.0),
              child: Image.asset('assets/images/iconPets.png',
                  color: pageImageColor)),
          Container(
              width: double.infinity,
              child: Text('Buscar pareja', style: pageTitleStyle)),
          Container(
            width: double.infinity,
            child: Text(
              'Tú mascota esta sola?, ahora puedes conseguirle una cita.',
              style: pageInfoStyle,
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Image.asset('assets/images/iconPets.png', color: pageImageColor),
          Text('¿Tú mascota se extravio?', style: pageTitleStyle),
          Text(
            'Aquí podras pedir ayuda a la comunidad para conseguirlo mas rapido.',
            style: pageInfoStyle,
          )
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Image.asset(
            'assets/images/adopta1.png',
            color: Colors.white,
            width: 200,
            height: 200,
          ),
          Text('¿Quieres una mascota?', style: pageTitleStyle),
          Text(
            'Aqui podras conseguir a tu mascota de sueños, adopta una mascota que podras hacer feliz y él a tí',
            style: pageInfoStyle,
          )
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Image.asset('assets/images/iconPets.png', color: pageImageColor),
          Text(
              '¿Necesitas ayuda para conseguir los articulos que necesita tu mascota?',
              style: pageTitleStyle),
          Text(
            'Aqui te mostramos las tiendas disponibles a tú alrededor',
            style: pageInfoStyle,
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Image.asset('assets/images/iconPets.png', color: pageImageColor),
          Text('¿Necesitas ayuda para conseguir los centros veterinarios?',
              style: pageTitleStyle),
          Text(
            'Aqui te mostramos los centros veterinarios disponibles a tú alrededor',
            style: pageInfoStyle,
          ),
        ],
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(
        background: ColorPalette.principal,
        proceedButtonStyle: ProceedButtonStyle(
          proceedpButtonText: Text("Continuar"),
          proceedButtonRoute: (context) {
            return Navigator.pushReplacementNamed(context, "login");
          },
        ),
        pages: onboardingPagesList,
        isSkippable: false,
        indicator: Indicator(
          indicatorDesign: IndicatorDesign.polygon(
            polygonDesign: PolygonDesign(
              polygon: DesignType.polygon_circle,
            ),
          ),
        ),
      ),
    );
  }
}
