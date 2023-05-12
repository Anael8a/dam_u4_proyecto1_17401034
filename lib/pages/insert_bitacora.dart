import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto1_17401034/service/bd_bitacora.dart';

class InsertarBitacora extends StatefulWidget {
final vehiculoId;
  const InsertarBitacora({Key? key, required this.vehiculoId}) : super(key: key);

  @override
  State<InsertarBitacora> createState() => _InsertarBitacoraState();
}

class _InsertarBitacoraState extends State<InsertarBitacora> {

  DateTime fechaControler = DateTime.now();
  TextEditingController eventoControler = TextEditingController();
  TextEditingController recursosControler = TextEditingController();
  TextEditingController verificoControler = TextEditingController();
  DateTime fechaverControler = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Bitacora'),),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              TextButton(onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context, initialDate: fechaControler,
                  firstDate: DateTime(2023,5), lastDate: DateTime(2222),
                );
                if (picked != null && picked != fechaControler) {
                  setState(() { fechaControler = picked; });
                }
              }, child: Text('Fecha: ${DateFormat.yMd().format(fechaControler)}'),),
              TextField(controller: eventoControler, decoration: const InputDecoration( labelText: 'Evento'),),
              TextField(controller: recursosControler, decoration: const InputDecoration( labelText: 'Recursos'),),
              TextField(controller: verificoControler, decoration: const InputDecoration( labelText: 'Verifico'),),
              TextButton(onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context, initialDate: fechaverControler,
                  firstDate: DateTime(2023,5), lastDate: DateTime(2222),
                );
                if (picked != null && picked != fechaverControler) {
                  setState(() { fechaverControler = picked; });
                }
              }, child: Text('Fecha Verifc: ${DateFormat.yMd().format(fechaverControler)}'),),
              ElevatedButton(onPressed: () async{
                await insertarBitacora(widget.vehiculoId, {
                  "evento": eventoControler.text,
                  "recursos": recursosControler.text,
                  "verifico": verificoControler.text,
                  "fecha": fechaControler,
                  "fechaverificacion": fechaverControler,
                }).then((_) {
                  Navigator.pop(context);
                });
              }, child: const Text("Guardar"))
            ],
          ),
        ),
      ),
    );
  }
}