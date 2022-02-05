import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heartmypet/Constant/Languages.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:heartmypet/Routes/routes.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
import 'package:heartmypet/utils/notifications.dart';
import 'blocks/provider.dart';

// COMPLETE: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

final _prefs = new PreferenciasUsuario();
Future main() async {
  notificationMain();

  await _prefs.initPrefs();

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(GetMaterialApp(
    home: MyApp(),
    translations: Languages(), // your translations
    locale: Locale('es', 'ES'), // translations will be displayed in that locale
    fallbackLocale: Locale('en', 'US'),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    notificationAlert(context);
    return FutureBuilder<void>(
        future: _initGoogleMobileAds(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Provider(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: _prefs.onboarding == true ? "onbording" : "login",
              routes: appRoute,
              theme: ThemeData(
                primaryColor: ColorPalette.principal,
              ),
            ),
          );
        });
  }

  // COMPLETE: Change return type to Future<InitializationStatus>
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
}
