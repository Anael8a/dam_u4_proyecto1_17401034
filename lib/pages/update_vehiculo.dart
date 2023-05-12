import 'package:dam_u4_proyecto1_17401034/pages/insert_vehiculo.dart';
import 'package:dam_u4_proyecto1_17401034/service/bd_vehiculo.dart';
import 'package:flutter/material.dart';


class ActualizarVehiculo extends StatefulWidget {
  const ActualizarVehiculo({Key? key}) : super(key: key);

  @override
  State<ActualizarVehiculo> createState() => _ActualizarVehiculoState();
}

class _ActualizarVehiculoState extends State<ActualizarVehiculo> {
  TextEditingController placaControler = TextEditingController();
  TextEditingController tipoControler = TextEditingController();
  TextEditingController numSerieControler = TextEditingController();
  TextEditingController combustibleControler = TextEditingController();
  TextEditingController tanqueControler = TextEditingController();
  TextEditingController trabajadorControler = TextEditingController();
  TextEditingController deptoControler = TextEditingController();
  TextEditingController resguarControler = TextEditingController();

  String ? selecTipo;

  @override
  Widget build(BuildContext context) {
    final Map arguments= ModalRoute.of(context)!.settings.arguments as Map? ??{};

    if(arguments.isNotEmpty){
      placaControler.text= arguments['placa']??'';
      tipoControler.text= arguments['tipo']??'';
      numSerieControler.text= arguments['numeroserie']??'';
      combustibleControler.text= arguments['combustible']??'';
      tanqueControler.text= arguments['tanque'].toString()??'';
      trabajadorControler.text= arguments['trabajador']??'';
      deptoControler.text= arguments['depto']??'';
      resguarControler.text= arguments['resguardadopor']??'';
    }
    String? tipo = arguments['tipo'];
    List<String> tiposVehiculo = ['Camion','Coche','Camioneta','Tracktor','Motocicleta'];

    if(!tiposVehiculo.contains(tipo)){
      tipo = tiposVehiculo[0]; //establece valor por defecto
    }



    return Scaffold(
      appBar: AppBar(title: Text("Actualizar Vehiculo"),),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: placaControler,decoration: InputDecoration(labelText: "Placa"),),
              SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                  value: selecTipo,
                  decoration: InputDecoration(labelText: "Tipo de vehiculo"),
                  items: <String>['Camion','Coche','Camioneta','Tracktor','Motocicleta'].map((String value) {
                    return DropdownMenuItem<String>(value:value,child: Text(value),);
                  }).toList(), onChanged: (newValue){
                setState(() {
                  selecTipo = newValue;
                });
              }),
              SizedBox(height: 10,),
              TextField(controller: numSerieControler,decoration: InputDecoration(labelText: "Numero de serie"),),
              TextField(controller: combustibleControler,decoration: InputDecoration(labelText: "Combustible"),),
              TextField(controller: tanqueControler,decoration: InputDecoration(labelText: "Tanque"),),
              TextField(controller: trabajadorControler,decoration: InputDecoration(labelText: "Trabajador"),),
              TextField(controller: deptoControler,decoration: InputDecoration(labelText: "Depto"),),
              TextField(controller: resguarControler,decoration: InputDecoration(labelText: "Resguardado por"),),
              ElevatedButton(onPressed: ()async{

               await updateVehiculo(arguments['uid'],placaControler.text,selecTipo!,numSerieControler.text,combustibleControler.text
                ,int.parse(tanqueControler.text),trabajadorControler.text,deptoControler.text,resguarControler.text).then((value) {
                  Navigator.pop(context);
               });
              }, child: const Text("Actualizar"))

            ],
          ),
        ),
      ),
    );
  }
}
