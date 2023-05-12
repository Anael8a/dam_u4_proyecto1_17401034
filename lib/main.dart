import 'package:dam_u4_proyecto1_17401034/bitacora.dart';
import 'package:dam_u4_proyecto1_17401034/pages/insert_bitacora.dart';
import 'package:dam_u4_proyecto1_17401034/pages/insert_vehiculo.dart';
import 'package:dam_u4_proyecto1_17401034/pages/update_bitacora.dart';
import 'package:dam_u4_proyecto1_17401034/pages/update_vehiculo.dart';
import 'package:dam_u4_proyecto1_17401034/vehiculo.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const Vehiculo(),
        '/Actualizar' : (context) => const ActualizarVehiculo(),
       '/Bitacora' : (context) => const Bitacora(vehiculoId: '',),
        '/InsertarVehiculo': (context) => const InsertarVehiculo(),
        '/ActualizarBitacora':(context) =>const ActualizarBitacora(vehiculoId: '',),
      },

    );
  }
}
