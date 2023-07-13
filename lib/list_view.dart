import 'package:flutter/material.dart';

import 'db/database.dart';
import 'model/evento.dart';

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final List<bool> selectedList;
  final Function(bool)? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  late List<Evento> eventos;
  bool isLoading = false;
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }
  @override
  void initState(){
    super.initState();
    refreshList();
  }

  Future refreshList() async {
    setState(() {
      isLoading = true;
    });
    eventos = await EventDatabase.instance.readAllEventos();
    setState(() {
      isLoading = false;
    });
  }

  @override 
  void dispose(){
    EventDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : eventos.isEmpty
                  ? const Text(
                      'No hay eventos registrados',
                      style: TextStyle(color: Colors.blue, fontSize: 24),
                    )
                  : buildList(),
        );
  }

  Widget buildList() => ListView.builder(
        itemCount: eventos.length,
        itemBuilder: (_, int index) {
          final note = eventos[index];
          return ListTile(
              onTap: () => _toggle(index),
              onLongPress: () {
                if (!widget.isSelectionMode) {
                  setState(() {
                    widget.selectedList[index] = true;
                  });
                  widget.onSelectionChange!(true);
                }
              },
              trailing: widget.isSelectionMode
                  ? Checkbox(
                      value: widget.selectedList[index],
                      onChanged: (bool? x) => _toggle(index),
                    )
                  : const SizedBox.shrink(),
              title: Text(note.title));
        });
}
