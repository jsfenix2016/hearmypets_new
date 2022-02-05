import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:heartmypet/Controllers/login_controller.dart';
import 'package:heartmypet/blocks/provider.dart';
import 'package:heartmypet/provider/preferencia_usuario.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
import 'package:heartmypet/utils/FondoCustom.dart';

class LoginPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();
  final prefs = new PreferenciasUsuario();
  final login_controller lc = Get.put(login_controller());

  void initPreference() async {
    await prefs.initPrefs();
    prefs.onboarding = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FondoCustomWidget(),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'titulo_login'.tr,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                _crearEmail(bloc),
                SizedBox(height: 10),
                _crearPassword(bloc),
                SizedBox(height: 20),
                _crearBoton(bloc),
              ],
            ),
          ),
          TextButton(
            child: Text('new_user'.tr),
            onPressed: () => lc.goToRegister(context),
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon:
                    Icon(Icons.alternate_email, color: ColorPalette.principal),
                hintText: "ejemplo@ejemplo.com",
                labelText: 'email'.tr,
                counterText: snapshot.data,
                errorText: snapshot.error,
              ),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.fromValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ElevatedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('pay_in'.tr),
            ),
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: ColorPalette.principal,
              onSurface: Colors.grey,
            ),
            onPressed: snapshot.hasData
                ? () {
                    lc.login(bloc, context);
                  }
                : null,
          );
        });
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: ColorPalette.principal),
                labelText: 'password'.tr,
                counterText: snapshot.data,
                errorText: snapshot.error,
              ),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

  Widget get dogImage {
    return Container(
      // You can explicitly set heights and widths on Containers.
      // Otherwise they take up as much space as their children.
      width: 100.0,
      height: 100.0,
      // Decoration is a property that lets you style the container.
      // It expects a BoxDecoration.
      decoration: BoxDecoration(
        // BoxDecorations have many possible properties.
        // Using BoxShape with a background image is the
        // easiest way to make a circle cropped avatar style image.
        shape: BoxShape.circle,
        image: DecorationImage(
          // Just like CSS's `imagesize` property.
          fit: BoxFit.cover,
          // A NetworkImage widget is a widget that
          // takes a URL to an image.
          // ImageProviders (such as NetworkImage) are ideal
          // when your image needs to be loaded or can change.
          // Use the null check to avoid an error.
          image: new AssetImage("assets/images/iconPets.png"),
        ),
      ),
    );
  }
}
