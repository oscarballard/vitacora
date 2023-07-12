import 'package:flutter/material.dart';
import 'package:tarea8/ListView.dart';

import 'create_evento.dart';
import 'grid_view.dart';
import 'lista.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter Demo', home: MyAppBody());
  }
}

class MyAppBody extends StatefulWidget {
  const MyAppBody({super.key});
  // Oscar Ballard 202010604
  @override
  State<MyAppBody> createState() => _MyAppBoodyState();
}

class _MyAppBoodyState extends State<MyAppBody> {
  int _paginaActual = 0;
  int _paginaActual2 = 0;
  late List<Widget> paginas;

  bool isSelectionMode = false;
  final int listLength = 30;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;

  final List<String> _title = [
    "Lista",
    "Grid",
    "Agregando evento",
    "",
    "",
    ""
  ];

  void _initPage() {
    paginas = [
      ListBuilder(
        isSelectionMode: isSelectionMode,
        selectedList: _selected,
        onSelectionChange: (bool x) {
          setState(() {
            isSelectionMode = x;
          });
        },
      ),
      GridBuilder(
        isSelectionMode: isSelectionMode,
        selectedList: _selected,
        onSelectionChange: (bool x) {
          setState(() {
            isSelectionMode = x;
          });
        },
      ),
      const CreateEvento()
      // const PaginaPerfil()
    ];
  }

  _MyAppBoodyState() {
    initializeSelection();
    _initPage();
  }
  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_paginaActual2]),
        leading: isSelectionMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    isSelectionMode = false;
                    if (isSelectionMode) {
                      _paginaActual = 0;
                      _paginaActual2 = 0;
                    } else {
                      _paginaActual = 1;
                      _paginaActual2 = 1;
                    }
                  });
                },
              )
            : const SizedBox(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                _paginaActual = 2;
                _paginaActual2 = 2;
              });
            },
          ),
          if (_isGridMode)
            IconButton(
              icon: const Icon(Icons.grid_on),
              onPressed: () {
                setState(() {
                  _isGridMode = false;
                });
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                setState(() {
                  _isGridMode = true;
                });
              },
            ),
          if (isSelectionMode)
            TextButton(
                child: !_selectAll
                    ? const Text(
                        'select all',
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        'unselect all',
                        style: TextStyle(color: Colors.white),
                      ),
                onPressed: () {
                  _selectAll = !_selectAll;
                  setState(() {
                    _selected =
                        List<bool>.generate(listLength, (_) => _selectAll);
                  });
                }),
        ],
        backgroundColor: Colors.blue,
      ),
      body: paginas[_paginaActual2],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _paginaActual = index;
            _paginaActual2 = index;
          });
        },
        currentIndex: _paginaActual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: "Personajes"),
          BottomNavigationBarItem(
              icon: Icon(Icons.punch_clock_rounded), label: "Momentos"),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

class PaginaPerfil extends StatelessWidget {
  const PaginaPerfil({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Text("Hola");
  }
}
