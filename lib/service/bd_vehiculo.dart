import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore DBV = FirebaseFirestore.instance;
var userRef = DBV.collection("vehiculo2").doc("bitacora");




Future<List> getVehiculo() async {
  List vehiculo = [];
  QuerySnapshot querySnapshot=await DBV.collection('vehiculo').get();
  for(var doc in querySnapshot.docs){
    final Map<String,dynamic> data = doc.data() as Map<String, dynamic>;
    final vehiculosobject = {
     "placa":data['placa'],
      "tipo":data['tipo'],
      "numeroserie":data['numeroserie'],
      "combustible":data['combustible'],
      "tanque":data['tanque'],
      "trabajador":data['trabajador'],
      "depto":data['depto'],
      "resguardadopor":data['resguardadopor'],
      "uid":doc.id,

    };
    vehiculo.add(vehiculosobject);
  }
  await Future.delayed(Duration(seconds: 2));
  return vehiculo;
}

//insert un vehiculo en bd
Future<void> insertVehiculo(
    String placa,
    String tipo,
    String numeroserie,
    String combustible,
    int tanque,
    String trabajador,
    String depto,
    String resguardadopor) async {
  await DBV.collection("vehiculo").add({
    "placa": placa,
    "tipo": tipo,
    "numeroserie": numeroserie,
    "combustible": combustible,
    "tanque": tanque,
    "trabajador": trabajador,
    "depto": depto,
    "resguardadopor": resguardadopor
  });
}

//actualizar un campo a la base de datos
Future<void> updateVehiculo(
    String uid,
    String newplaca,
    String newtipo,
    String newnumeroserie,
    String newcombustible,
    int     newtanque,
    String newtrabajador,
    String newdepto,
    String newresguardadopor,
) async {
  await DBV.collection("vehiculo").doc(uid).set({
    "placa": newplaca,
    "tipo": newtipo,
    "numeroserie": newnumeroserie,
    "combustible": newcombustible,
    "tanque": newtanque,
    "depto": newdepto,
    "resguardadopor": newresguardadopor
  });
}

///borrar datos de firebase
///
Future<void> borrarVehiculos(String uid)async{
  await DBV.collection("vehiculo").doc(uid).delete();
}





//insert un vehiculo en bitacora
/*Future<void> insertVB(
    String placa,
    String tipo,
    String numeroserie,
    String combustible,
    int tanque,
    String trabajador,
    String depto,
    String resguardadopor) async {
  QuerySnapshot querySnapshot=await DBV.collection('vehiculo').get();
  for(var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    var collectionRef = FirebaseFirestore.instance.collection('vehiculo2');
    var subcollectionRef = collectionRef.doc("uid":doc.id,).collection('mi_subcoleccion');
  }
  await userRef.add({
    "placa": placa,
    "tipo": tipo,
    "numeroserie": numeroserie,
    "combustible": combustible,
    "tanque": tanque,
    "trabajador": trabajador,
    "depto": depto,
    "resguardadopor": resguardadopor
  });
}*/