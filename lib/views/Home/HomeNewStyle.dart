import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:heartmypet/Constant/colorsPalette.dart';
import 'package:heartmypet/Model/producto_model.dart';
import 'package:heartmypet/provider/usuario_provider.dart';
//import 'package:heartmypet/utils/FondoCustom.dart';

class HomeNew extends StatefulWidget {
  @override
  _HomeNewState createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  @override
  void initState() {
    super.initState();

    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );

    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
                  AwesomeNotifications().setGlobalBadgeCounter(value - 1),
            );
      }
      Navigator.pushNamed(context, "miUser");
    });
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  // Widget _loginForm(BuildContext context) {
  //   return Container(
  //     color: Colors.transparent,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: GridView(
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   boxShadow: [
  //                     BoxShadow(
  //                         color: Colors.black.withOpacity(0.5),
  //                         spreadRadius: 1,
  //                         blurRadius: 5,
  //                         offset: Offset(0.0, 5.0)),
  //                   ],
  //                   borderRadius: BorderRadius.circular(20),
  //                   color: Colors.white),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(40.0),
  //                 child: Column(
  //                   children: [
  //                     Icon(
  //                       Icons.search,
  //                       size: 40,
  //                       color: ColorPalette.principal,
  //                     ),
  //                     Text(
  //                       "Buscar match",
  //                       style: TextStyle(
  //                           fontSize: 8,
  //                           color: ColorPalette.principal,
  //                           fontWeight: FontWeight.bold),
  //                       textAlign: TextAlign.center,
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   boxShadow: [
  //                     BoxShadow(
  //                         color: Colors.black.withOpacity(0.5),
  //                         spreadRadius: 1,
  //                         blurRadius: 5,
  //                         offset: Offset(0.0, 5.0)),
  //                   ],
  //                   borderRadius: BorderRadius.circular(20),
  //                   color: Colors.white),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(40.0),
  //                 child: Column(
  //                   children: [
  //                     new Image.asset(
  //                       "assets/images/iconPets.png",
  //                       color: ColorPalette.principal,
  //                       width: 50,
  //                       height: 50,
  //                     ),
  //                     Text("Mis likes",
  //                         style: TextStyle(
  //                             fontSize: 8,
  //                             color: ColorPalette.principal,
  //                             fontWeight: FontWeight.bold),
  //                         textAlign: TextAlign.center)
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   boxShadow: [
  //                     BoxShadow(
  //                         color: Colors.black.withOpacity(0.5),
  //                         spreadRadius: 1,
  //                         blurRadius: 5,
  //                         offset: Offset(0.0, 5.0)),
  //                   ],
  //                   borderRadius: BorderRadius.circular(20),
  //                   color: Colors.white),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(40.0),
  //                 child: Column(
  //                   children: [
  //                     Icon(
  //                       Icons.home,
  //                       size: 40,
  //                       color: ColorPalette.principal,
  //                     ),
  //                     Text(
  //                       "mascotas extraviadas",
  //                       style: TextStyle(
  //                           fontSize: 8,
  //                           color: ColorPalette.principal,
  //                           fontWeight: FontWeight.bold),
  //                       textAlign: TextAlign.center,
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   boxShadow: [
  //                     BoxShadow(
  //                         color: Colors.black.withOpacity(0.5),
  //                         spreadRadius: 1,
  //                         blurRadius: 5,
  //                         offset: Offset(0.0, 5.0)),
  //                   ],
  //                   borderRadius: BorderRadius.circular(20),
  //                   color: Colors.white),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(40.0),
  //                 child: Column(
  //                   children: [
  //                     Icon(
  //                       Icons.store,
  //                       size: 40,
  //                       color: ColorPalette.principal,
  //                     ),
  //                     Text(
  //                       "Tiendas",
  //                       style: TextStyle(
  //                           fontSize: 8,
  //                           color: ColorPalette.principal,
  //                           fontWeight: FontWeight.bold),
  //                       textAlign: TextAlign.center,
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   boxShadow: [
  //                     BoxShadow(
  //                         color: Colors.black.withOpacity(0.5),
  //                         spreadRadius: 1,
  //                         blurRadius: 5,
  //                         offset: Offset(0.0, 5.0)),
  //                   ],
  //                   borderRadius: BorderRadius.circular(20),
  //                   color: Colors.white),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(40.0),
  //                 child: Column(
  //                   children: [
  //                     Icon(
  //                       Icons.chat,
  //                       size: 40,
  //                       color: ColorPalette.principal,
  //                     ),
  //                     Text("Chats",
  //                         style: TextStyle(
  //                             fontSize: 8,
  //                             color: ColorPalette.principal,
  //                             fontWeight: FontWeight.bold))
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  ProductoModel producto = new ProductoModel();
  Image imgNew;

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                backgroundColor: ColorPalette.principal,
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Container(
                    height: 30,
                    width: size.width,
                    // color: Colors.black.withOpacity(0.2),
                    child: Center(
                      child: Text(
                        " Javier Santana ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  background: Image.asset(
                    "assets/images/yo.jpg",
                    width: 200,
                    height: 200.0,
                    fit: BoxFit.cover,
                    scale: 0.5,
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0.0, 5.0)),
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.search,
                                    size: 40,
                                    color: ColorPalette.principal,
                                  ),
                                  Text(
                                    "Buscar pareja",
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: ColorPalette.principal,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "home");
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0.0, 5.0)),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              new Image.asset(
                                "assets/images/iconPets.png",
                                color: ColorPalette.principal,
                                width: 50,
                                height: 50,
                              ),
                              Text("Me gustan",
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: ColorPalette.principal,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0.0, 5.0)),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.home,
                                size: 40,
                                color: ColorPalette.principal,
                              ),
                              Text(
                                "mascotas extraviadas",
                                style: TextStyle(
                                    fontSize: 9,
                                    color: ColorPalette.principal,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0.0, 5.0)),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.store,
                                size: 40,
                                color: ColorPalette.principal,
                              ),
                              Text(
                                "Tiendas",
                                style: TextStyle(
                                    fontSize: 9,
                                    color: ColorPalette.principal,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2.5,
                                  offset: Offset(0.0, 5.0)),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.chat,
                                size: 40,
                                color: ColorPalette.principal,
                              ),
                              Text("Chats",
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: ColorPalette.principal,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0.0, 5.0)),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.medical_services,
                                size: 40,
                                color: ColorPalette.principal,
                              ),
                              Text(
                                "Medicos",
                                style: TextStyle(
                                    fontSize: 9,
                                    color: ColorPalette.principal,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0.0, 5.0)),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 40,
                                color: ColorPalette.principal,
                              ),
                              Text(
                                "Calendario",
                                style: TextStyle(
                                    fontSize: 9,
                                    color: ColorPalette.principal,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
