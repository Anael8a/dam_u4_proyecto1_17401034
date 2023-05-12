import 'package:dam_u4_proyecto1_17401034/bitacora.dart';
import 'package:dam_u4_proyecto1_17401034/pages/insert_vehiculo.dart';
import 'package:dam_u4_proyecto1_17401034/pages/update_vehiculo.dart';
import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto1_17401034/service/bd_vehiculo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_core/firebase_core.dart';

class Vehiculo extends StatefulWidget {
  const Vehiculo({Key? key}) : super(key: key);
  @override
  State<Vehiculo> createState() => _VehiculoState();
}
class _VehiculoState extends State<Vehiculo> {


  @override

Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Control de Vehiculos TEC TEPIC"),),
      body: FutureBuilder(
        future: getVehiculo(),
        builder: ((context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {

                  return Dismissible(
                    onDismissed:(direction)async{
                        await borrarVehiculos(snapshot.data?[index]['uid']);
                        setState(() {});
                    },
                    confirmDismiss: (direction)async{
                      bool result = false;
                      setState(() {});

                      result = await showDialog(context: context, builder: (context){

                        return AlertDialog(
                          title:  Text("Esta seguro de querer eliminar a ${snapshot.data?[index]['placa']}?"),

                          actions: [
                            TextButton(onPressed: (){
                              return Navigator.pop(context,false);
                            }, child: Text("Cancelar")),
                            TextButton(onPressed: (){
                              return Navigator.pop(context,true);
                            }, child: Text("Eliminar")),
                            TextButton(
                              child: Text('Ver Bitácoras de Uso'),
                              onPressed: () async{
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Bitacora(vehiculoId: snapshot.data?[index]['uid'] ?? ''),
                                  ),
                                );
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                            ),

                          ],

                        );
                      });

                      return result;
                    },
                    background: Container(
                      child: Icon(Icons.delete_forever),
                      color:Colors.blue,
                    ),
                    key: Key(snapshot.data?[index]['uid']),
                    child:ListTile(
                      title: Text(snapshot.data?[index]['placa'] ?? ''
                      ,style:TextStyle(fontWeight: FontWeight.bold),),

                    subtitle: Text(
                      'Departamento: ${snapshot.data?[index]['depto']??''}\n'
                      'Trabajador: ${snapshot.data?[index]['trabajador']?? ''}\n'
                      'Tipo vehiculo: ${snapshot.data?[index]['tipo']?? ''}',

                    ),
                    onTap: (()async {

                   await Navigator.pushNamed(context, '/Actualizar',arguments: {
                       "placa":snapshot.data?[index]['placa'],
                       "uid":snapshot.data?[index]['uid'],
                       "tipo":snapshot.data?[index]['tipo'],
                       "combustible":snapshot.data?[index]['combustible'],
                       "depto":snapshot.data?[index]['depto'],
                       "numeroserie":snapshot.data?[index]['numeroserie'],
                       "resguardadopor":snapshot.data?[index]['resguardadopor'],
                       "tanque":snapshot.data?[index]['tanque'],
                       "trabajador":snapshot.data?[index]['trabajador'],
                     });
                        setState(() {

                        });
                    }),
                  ));
                },
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
        await Navigator.push(context, MaterialPageRoute(builder: (builder)=> InsertarVehiculo()));
          setState(() {});
          },
        child: Icon(Icons.add),
      ),
    );
  }
}


//agregar el mostrar para poder dar opcion de borrar, actualizar, ir a bitacora

