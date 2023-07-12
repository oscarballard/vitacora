import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class CreateEvento extends StatefulWidget {
  const CreateEvento({super.key});

  @override
  State<CreateEvento> createState() => _CreateEventoState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _CreateEventoState extends State<CreateEvento> {
  TextEditingController dateinput = TextEditingController();
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
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
                  print(value);
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              TextField(
                  controller: myController,
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
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
