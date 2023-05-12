import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

FirebaseFirestore DBV = FirebaseFirestore.instance;


Future<List> getBitacora(String vehiculoId) async {
  List bitacora = [];
  QuerySnapshot queryBitacora = await DBV.collection('vehiculo').doc(vehiculoId).collection('bitacora').get();
  for(var doc in queryBitacora.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final bitacoraDoc = {
      "fecha": data['fecha'],
      "evento":data['evento'],
      "recursos":data['recursos'],
      "verifico":data['verifico'],
      "fechaverificacion":data['fechaverificacion'],
      "uid":doc.id,
    };
    bitacora.add(bitacoraDoc);
  }
  await Future.delayed(const Duration(seconds: 2));
  return bitacora;
}

Future<void> InsertarBitacoras(
     DateTime fecha, String evento,
    String recursos, String verifico, DateTime fechaverificacion,
    ) async {
  await DBV.collection('bitacoras').add(
      {
        "fecha": fecha,
        "evento": evento,
        "recursos": recursos,
        "verifico": verifico,
        "fechaverificacion": fechaverificacion,
      }
  );
}

Future<void> insertarBitacora(String vehiculoId, Map<String, dynamic> bitacoraData) async{
  await DBV.collection('vehiculo').doc(vehiculoId).collection('bitacora').add(bitacoraData);
}



Future<void> actualizarBitacora(String vehiculoId, String bitacoraId, String verifico, DateTime fechaverificacion) async {
  await DBV.collection('vehiculo').doc(vehiculoId).collection('bitacora').doc(bitacoraId).update({
    'verifico': verifico,
    'fechaverificacion': fechaverificacion,
  });
}















Future<List<Map<String, dynamic>>> getBitacorasPorFecha(DateTime fecha) async {
  List<Map<String, dynamic>> bitacorasPorFecha = [];
  QuerySnapshot vehiculosSnapshot = await FirebaseFirestore.instance.collection('vehiculo').get();

  for (var vehiculo in vehiculosSnapshot.docs) {
    QuerySnapshot bitacorasSnapshot = await vehiculo.reference.collection('bitacora')
        .where('fecha', isEqualTo: Timestamp.fromDate(fecha))
        .get();

    for (var bitacora in bitacorasSnapshot.docs) {
      bitacorasPorFecha.add(bitacora.data() as Map<String, dynamic>);
    }
  }

  return bitacorasPorFecha;
}


Future<List<Map<String, dynamic>>> getBitacorasPorPlaca(String placa) async {
  List<Map<String, dynamic>> bitacoraPorPlaca = [];

  QuerySnapshot queryVehiculo = await DBV.collection('vehiculo')
      .where('placa', isEqualTo: placa)
      .get();

  if(queryVehiculo.docs.isNotEmpty){
    String vehiculoId = queryVehiculo.docs.first.id;
    QuerySnapshot queryBitacora = await DBV.collection('vehiculo').doc(vehiculoId).collection('bitacora').get();

    for(var doc in queryBitacora.docs){
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final bitacoraDoc = {
        "fecha": DateFormat('yyyy-MM-dd – kk:mm').format(data['fecha'].toDate()),
        "evento":data['evento'],
        "recursos":data['recursos'],
        "verifico":data['verifico'],
        "fechaverificacion":data['fechaverificacion'],
        "uid":doc.id,
      };
      bitacoraPorPlaca.add(bitacoraDoc);
    }
  }

  await Future.delayed(const Duration(seconds: 2));
  return bitacoraPorPlaca;
}