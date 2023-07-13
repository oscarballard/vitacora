import 'package:flutter/material.dart';

class BtnFoto extends StatelessWidget {
  const BtnFoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: SingleChildScrollView(
        child: Column(children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              child: const Row(
                children: [
                  Expanded(
                      child: Text(
                    "Tomar una foto",
                    style: TextStyle(fontSize: 16),
                  )),
                  Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Row(
                children: [
                  Expanded(
                      child: Text(
                    "Selecciones una foto",
                    style: TextStyle(fontSize: 16),
                  )),
                  Icon(
                    Icons.image,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
