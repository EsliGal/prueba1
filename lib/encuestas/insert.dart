import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/encuestas/generar_link.dart';
import 'package:prueba1/listado_screen.dart';

class Ccreate extends StatefulWidget {
  const Ccreate({super.key});
  @override
  State<Ccreate> createState() => CcreateState();
}

class CcreateState extends State<Ccreate> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  DatabaseReference? dbRef;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('encuestas');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar encuesta'),
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
                controller: descripcionController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Descripción',
                ),
                //maxLength: 10,
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
      String link = '';
      final now = DateTime.now();
      String dt = now.microsecondsSinceEpoch.toString();
      String codigo = 'cod-$dt';
      /*Future<String> link =*/
      print(DynamicLinkProvider().createLink(codigo).then((value) {
        link = (value);
        print(link);
      }));
      print(link);
      if (nombreController.text != '') {
        Map<String, String> encuestas = {
          'nombre': nombreController.text,
          'descripcion': descripcionController.text,
          'codigo': codigo,
          'link': link
        };

        dbRef!.push().set(encuestas).whenComplete(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const ListadoScreen(),
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
