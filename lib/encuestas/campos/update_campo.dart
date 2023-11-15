import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/encuestas/update.dart';

class UpdateCampo extends StatefulWidget {
  final String encuestaKey;
  final String campoKey;
  const UpdateCampo(
      {super.key, required this.encuestaKey, required this.campoKey});

  @override
  State<UpdateCampo> createState() => _UpdateCampoState();
}

class _UpdateCampoState extends State<UpdateCampo> {
  TextEditingController nombreCampoController = TextEditingController();
  TextEditingController tituloController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  String requeridoController = 'false';

  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance
        .ref()
        .child('encuestas/${widget.encuestaKey}');
    campoData();
  }

  void campoData() async {
    DataSnapshot snapshot = await dbRef!.child(widget.campoKey).get();

    Map campo = snapshot.value as Map;

    setState(() {
      nombreCampoController.text = campo['nombreCampo'];
      tituloController.text = campo['titulo'];
      tipoController = campo['tipo'];
      requeridoController = campo['requerido'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualización Campo'),
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
              TextFormField(
                controller: nombreCampoController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: tituloController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: tipoController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton(
                  hint: Text(requeridoController),
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
                  update();
                },
                child: const Text(
                  "Actualizar",
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

  update() async {
    try {
      if (nombreCampoController.text != '') {
        Map<String, String> campo = {
          "nombreCampo": nombreCampoController.text,
          "titulo": tituloController.text,
          "requerido": requeridoController,
          "tipo": tipoController.text
        };

        dbRef!.child(widget.campoKey).update(campo).whenComplete(() {
          Navigator.pushReplacement(
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
