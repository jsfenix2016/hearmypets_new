// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:heartmypet/Constant/colorsPalette.dart';
// import 'package:geocoding/geocoding.dart';

// class LocationCustomWidget extends StatefulWidget {
//   LocationCustomWidget({Key key, @required this.onChanged}) : super(key: key);

//   final ValueChanged<String> onChanged;

//   @override
//   _LocationCustomWidgetState createState() => _LocationCustomWidgetState();
// }

// class _LocationCustomWidgetState extends State<LocationCustomWidget> {
//   Position _currentPosition;
//   //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

//   String _currentAddress;
//   void _selectOption(String value) {
//     setState(() {
//       widget.onChanged(value);
//     });
//   }

//   _getCurrentLocation() async {
//     _currentPosition = await _determinePosition();

//     print(_currentPosition.latitude.toString());
//     // geolocator
//     //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//     //     .then((Position position) {
//     //   setState(() {
//     //     _currentPosition = position;
//     //   });

//     _getAddressFromLatLng();
//     // }).catchError((e) {
//     //   print(e);
//     // });
//   }

//   Future _getAddressFromLatLng() async {
//     // List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);

//     try {
//       List<Placemark> p = await placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);

//       Placemark place = p[0];

//       setState(() {
//         _currentAddress =
//             "${place.locality}, ${place.postalCode}, ${place.country}";
//         controlador.text = _currentAddress;
//         _selectOption(_currentAddress);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }

//   // String valor = "";

//   TextEditingController controlador = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       width: double.infinity,
//       child: Stack(
//         children: <Widget>[
//           TextField(
//             decoration: InputDecoration(
//               labelText: "Coloca tu dirección",
//             ),
//             readOnly: false,
//             controller: controlador,
//           ),
//           Positioned(
//             top: 15,
//             right: 0.0,
//             child: Container(
//               alignment: Alignment.centerLeft,
//               color: Colors.transparent,
//               width: 30.0,
//               height: 40,
//               child: IconButton(
//                 alignment: Alignment.centerLeft,
//                 color: ColorPalette.blueGreen,
//                 icon: Icon(Icons.location_on),
//                 onPressed: () {
//                   _getCurrentLocation();
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
