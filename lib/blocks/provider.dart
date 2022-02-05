import 'package:flutter/material.dart';
import 'package:heartmypet/blocks/login_bloc.dart';
import 'package:heartmypet/blocks/productos_block.dart';
import 'package:heartmypet/blocks/register_block.dart';
import 'package:heartmypet/blocks/user_block.dart';
export 'package:heartmypet/blocks/login_bloc.dart';

class Provider extends InheritedWidget {
  
  final registerBloc = new RegisterBloc();
  final loginBloc = new LoginBloc();
  final _productosBloc = new ProductosBlock();
  final _userBloc = new UserBlock();

  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).loginBloc;
  }

  static RegisterBloc registerBlock(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).registerBloc;
  }

  static ProductosBlock productosBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())
        ._productosBloc;
  }

  static UserBlock userBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())
        ._userBloc;
  }
}
