import 'dart:async';

import 'package:heartmypet/blocks/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  //final _termsController = BehaviorSubject<bool>();
  final _cargandoController = BehaviorSubject<bool>();

// recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  // Stream<bool> get termsStream =>
  //     _termsController.stream.transform(validarCheck);
  Stream<bool> get cargando => _cargandoController.stream;

  Stream<bool> get fromValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

//Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  //Function(bool) get changeCheck => _termsController.sink.add;

//Obtener ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  //bool get terms => _termsController.value;

  void agregarRegistro(RegisterBloc regist) async {
    _cargandoController.sink.add(true);
    //await _productosProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    //_termsController?.close();
    _cargandoController?.close();
  }
}
