import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/encuestas/update.dart';

class CreateCampo extends StatefulWidget {
  final String encuestaKey;
  const CreateCampo({super.key, required this.encuestaKey});

  @override
  State<CreateCampo> createState() => _CreateCampoState();
}

class _CreateCampoState extends State<CreateCampo> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController tituloController = TextEditingController();
  String requeridoController = 'false';
  TextEditingController tipoController = TextEditingController();
  DatabaseReference? dbRef;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance
        .ref()
        .child('encuestas/${widget.encuestaKey}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar campo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: nombreController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Nombre',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: tituloController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Titulo',
                ),
                //maxLength: 10,
              ),
              const SizedBox(height: 16.0),
              Center(
                child: DropdownButton(
                    hint: const Text("Seleccione requerido"),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    items: const [
                      DropdownMenuItem(
                        child: Text("Si"),
                        value: true,
                      ),
                      DropdownMenuItem(
                        child: Text("No"),
                        value: false,
                      ),
                    ],
                    onChanged: (value) {
                      requeridoController = value.toString();
                    }),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                child: TextField(
                  controller: tipoController,
                  decoration: const InputDecoration(
                    hintText: 'Tipo Campo',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: 200,
                color: Colors.blue,
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () {
                  create();
                },
                child: const Text(
                  "Agregar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  create() async {
    try {
      if (nombreController.text != '') {
        Map<String, String> encuestas = {
          "nombreCampo": nombreController.text,
          "titulo": tituloController.text,
          "requerido": requeridoController,
          "tipo": tipoController.text
        };

        dbRef!.push().set(encuestas).whenComplete(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UpdateRecord(
                encuestaKey: widget.encuestaKey,
              ),
            ),
          );
        });
      }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
