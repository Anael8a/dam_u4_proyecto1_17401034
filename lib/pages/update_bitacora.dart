import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto1_17401034/service/bd_bitacora.dart';

class ActualizarBitacora extends StatefulWidget {
  final String vehiculoId;
  const ActualizarBitacora({Key? key, required this.vehiculoId}) : super(key: key);

  @override
  State<ActualizarBitacora> createState() => _ActualizarBitacoraState();
}

class _ActualizarBitacoraState extends State<ActualizarBitacora> {

  TextEditingController verifControler = TextEditingController();
  DateTime fechaVerControler = DateTime.now();

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    if (arguments.isNotEmpty) {

      verifControler.text = arguments['verifico'] ?? '';
      Timestamp fechaDB = arguments['fechaverificacion'];
      int fechaEnSeg = fechaDB.millisecondsSinceEpoch;
      DateTime fechaVCtrlInt = DateTime.fromMillisecondsSinceEpoch(fechaEnSeg);
      fechaVerControler = fechaVCtrlInt;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Bitacora'),),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: verifControler, decoration: const InputDecoration(hintText: 'Verifico:', labelText: 'Verifico'), autofocus: true,),
              TextButton(onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context, initialDate: fechaVerControler,
                  firstDate: DateTime(2023,5), lastDate: DateTime(2222),
                );
                if (picked != null && picked != fechaVerControler) {
                  setState(() { fechaVerControler = picked; });
                }
              }, child: Text('Fecha: ${DateFormat.yMd().format(fechaVerControler)}'),),
              ElevatedButton(onPressed: () async {
                await ActualizarBitacora(vehiculoId: '',key: ,
                ).then((_) {
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
