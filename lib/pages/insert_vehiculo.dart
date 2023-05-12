import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto1_17401034/service/bd_vehiculo.dart';

class InsertarVehiculo extends StatefulWidget {
  const InsertarVehiculo({Key? key}) : super(key: key);

  @override
  State<InsertarVehiculo> createState() => _InsertarVehiculoState();
}

class _InsertarVehiculoState extends State<InsertarVehiculo> {
 TextEditingController placaControler = TextEditingController();
 TextEditingController tipoControler = TextEditingController();
 TextEditingController numSerieControler = TextEditingController();
 TextEditingController combustibleControler = TextEditingController();
 TextEditingController tanqueControler = TextEditingController();
 TextEditingController trabControler = TextEditingController();
 TextEditingController deptoControler = TextEditingController();
 TextEditingController resguardoControler = TextEditingController();

String? selecTipo;


 @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Vehiculos"),),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: placaControler,decoration: InputDecoration(labelText:"Placa" ),),
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
              TextField(controller: numSerieControler,decoration: InputDecoration(labelText:"Numero Serie" ),),
              TextField(controller: combustibleControler,decoration: InputDecoration(labelText:"Combustible" ),),
              TextField(controller: tanqueControler,decoration: InputDecoration(labelText:"Tanque" ),),
              TextField(controller: trabControler,decoration: InputDecoration(labelText:"Trabajador" ),),
              TextField(controller: deptoControler,decoration: InputDecoration(labelText:"Depto" ),),
              TextField(controller: resguardoControler,decoration: InputDecoration(labelText:"Resguardado por" ),),
              ElevatedButton(onPressed: ()async{

                await insertVehiculo(placaControler.text,selecTipo!,
                    numSerieControler.text,combustibleControler.text
                    ,int.parse(tanqueControler.text),trabControler.text,
                    deptoControler.text,resguardoControler.text).then((value){
                  Navigator.pop(context);

                });
              }, child: Text("Insertar"),),
            ],
          ),
        ),
      ),
    );
  }
}
