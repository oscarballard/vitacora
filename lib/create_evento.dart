import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:tarea8/model/evento.dart';
import 'package:tarea8/widget/btn_foto.dart';

import 'db/database.dart';

// Define a custom Form widget.
// ignore: must_be_immutable
class CreateEvento extends StatefulWidget {
  late int? id = 0;
  CreateEvento({Key? key, this.id}) : super(key: key);

  @override
  State<CreateEvento> createState() => _CreateEventoState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _CreateEventoState extends State<CreateEvento> {
  TextEditingController dateinput = TextEditingController();
  final myController = TextEditingController();
  final myControllerDescripcion = TextEditingController();
  late String title;
  late String descripcion;
  late DateTime fecha;
  late int id = 0;
  File imagen;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                  controller: myController,
                  decoration: const InputDecoration(
                    labelText: "Titulo",
                    // hintText: "Enter your email",
                    prefixIcon: Icon(Icons.title),
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold), //hint text style
                    labelStyle: TextStyle(
                        fontSize: 13, color: Colors.blue), //label style
                  )),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Fecha',
                ),
                mode: DateTimeFieldPickerMode.time,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) =>
                    (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  fecha = value;
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              TextField(
                  controller: myControllerDescripcion,
                  minLines: 3,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: "Descripcion",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold), //hint text style
                    labelStyle: TextStyle(
                        fontSize: 13, color: Colors.blue), //label style
                  )),
              const Padding(
                padding: EdgeInsets.all(25.0),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      opciones(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    child: const SizedBox(
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.blue,
                      ),
                    ),
                  )),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      // Acción a realizar al presionar el botón
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    child: const SizedBox(
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.voice_chat,
                        size: 50,
                        color: Colors.blue,
                      ),
                    ),
                  )),
                ],
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: addOrUpdateNote,
        tooltip: 'Show me the value!',
        child: const Icon(Icons.save),
      ),
    );
  }

  Future updateNote() async {
    final note = Evento(
      title: myController.text,
      fecha: fecha,
      descripcion: myControllerDescripcion.text,
      pathImage: '',
      pathVoice: '',
    );

    await EventDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Evento(
      title: myController.text,
      fecha: fecha,
      descripcion: myControllerDescripcion.text,
      pathImage: '',
      pathVoice: '',
    );
    await EventDatabase.instance.create(note);
  }

  void addOrUpdateNote() async {
    final isUpdating = widget.id != 0; // Usar widget.id en lugar de id
    if (isUpdating) {
      await updateNote();
    } else {
      await addNote();
    }

    Navigator.of(context).pop();
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const BtnFoto();
        });
  }
}
