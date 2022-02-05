import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:
  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...
*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET del token
  get idUser {
    return _prefs.getInt('idlocal') ?? -1;
  }

  set idUser(int value) {
    _prefs.setInt('idlocal', value);
  }

  // GET y SET del token
  get terms {
    return _prefs.getBool('terms') ?? false;
  }

  set terms(bool value) {
    _prefs.setBool('terms', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

// GET y SET del token
  get securityKey {
    return _prefs.getString('securityKey') ?? '';
  }

  set securityKey(String value) {
    _prefs.setString('securityKey', value);
  }

  // GET y SET del Onboarding
  get onboarding {
    return _prefs.getBool('onboard') ?? false;
  }

  set onboarding(bool value) {
    _prefs.setBool('onboard', value);
  }
}
