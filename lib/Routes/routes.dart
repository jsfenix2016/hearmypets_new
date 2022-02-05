import 'package:flutter/material.dart';
import 'package:heartmypet/views/Chat/chat_page.dart';
import 'package:heartmypet/views/Chat/userchat_page.dart';
import 'package:heartmypet/views/Home/home_page.dart';
import 'package:heartmypet/views/Landing/landing_page.dart';
import 'package:heartmypet/views/Login/login_page.dart';
import 'package:heartmypet/views/Onboarding/onboarding_view.dart';
import 'package:heartmypet/views/Profile/MyPets/Preview/preview_page.dart';
import 'package:heartmypet/views/Profile/editUser.dart';
import 'package:heartmypet/views/Register/registro_page.dart';
import 'package:heartmypet/views/agregar_producto.dart';
import 'package:heartmypet/views/mis_mascotas.dart';
import 'package:heartmypet/views/product_page.dart';

final Map<String, Widget Function(BuildContext)> appRoute = {
  "onbording": (BuildContext context) => OnboardingPage(),
  "login": (BuildContext context) => LoginPage(),
  "registro": (BuildContext context) => RegistroPage(),
  "home": (BuildContext context) => HomePage(),
  "product": (BuildContext context) => ProductPage(),
  "addProduct": (BuildContext context) => AddPage(),
  "mismascotas": (BuildContext context) => MisMacotas(),
  "miUser": (BuildContext context) => EditUserPage(),
  "preview": (BuildContext context) => PreviewPage()
};
