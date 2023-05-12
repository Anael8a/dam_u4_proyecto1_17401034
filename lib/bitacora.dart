import 'package:dam_u4_proyecto1_17401034/pages/insert_bitacora.dart';
import 'package:dam_u4_proyecto1_17401034/pages/update_vehiculo.dart';
import 'package:dam_u4_proyecto1_17401034/pages/update_bitacora.dart';

import 'package:dam_u4_proyecto1_17401034/service/bd_bitacora.dart';
import 'package:flutter/material.dart';

class Bitacora extends StatefulWidget {
  final String vehiculoId;
  const Bitacora({Key? key, required this.vehiculoId}) : super(key: key);

  @override
  State<Bitacora> createState() => _BitacoraState();
}

class _BitacoraState extends State<Bitacora> {

  TextEditingController verificoController = TextEditingController();
  DateTime fechaV = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String vehiculoId = widget.vehiculoId;

    return  Scaffold(
      appBar: AppBar(title: Text("Bitacora de Vehiculos"),),
      body: FutureBuilder(
        future: getBitacora(widget.vehiculoId),
        builder: ((context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {

                return ListTile(
                  title: Text(snapshot.data?[index]['evento']??''),
                  subtitle: Text(snapshot.data?[index]['verifico']??''),
                  trailing: Text(snapshot.data?[index]['recursos']),
                  onTap: (()async{
                    await Navigator.pushNamed(context, '/ActualizarBitacora',arguments: {
                        "fecha":snapshot.data?[index]['fecha'],
                      "uid":snapshot.data?[index]['uid'],
                      "evento":snapshot.data?[index]['evento'],
                      "recursos":snapshot.data?[index]['recursos'],
                      "verifico":snapshot.data?[index]['verifico'],
                      "fecharverificacion":snapshot.data?[index]['fecharverificacion'],
                      "placa":snapshot.data?[index]['placa'],

                    });
                    Navigator.pop(context);
                  }),
                );
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
          await Navigator.push(context, MaterialPageRoute(builder: (builder)=> InsertarBitacora(vehiculoId: vehiculoId,)));
          setState(() {

          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
