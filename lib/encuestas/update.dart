import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/encuestas/campos/insert_campo.dart';
import 'package:prueba1/encuestas/campos/update_campo.dart';
import 'package:prueba1/listado_screen.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class UpdateRecord extends StatefulWidget {
  final String encuestaKey;
  const UpdateRecord({super.key, required this.encuestaKey});

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  String codigo = '';
  DatabaseReference? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('encuestas');
    encuestaData();
  }

  void encuestaData() async {
    DataSnapshot snapshot = await dbRef!.child(widget.encuestaKey).get();

    Map encuesta = snapshot.value as Map;

    setState(() {
      nombreController.text = encuesta['nombre'];
      descripcionController.text = encuesta['descripcion'];
      codigo = encuesta['codigo'];
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference dbRefCampo = FirebaseDatabase.instance
        .ref()
        .child('encuestas/${widget.encuestaKey}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualización'),
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
              Center(
                child: Text(codigo),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descripcionController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
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
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: 200,
                color: Colors.blueAccent,
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateCampo(
                        encuestaKey: widget.encuestaKey,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Agregar campo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //---Campos---------------------------------------------------------
              const SizedBox(height: 15.0),
              const Center(
                child: Text(
                  'Listado de campos',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15.0),
              FirebaseAnimatedList(
                query: dbRefCampo,
                shrinkWrap: true,
                itemBuilder: (context, snapshot2, animation, index) {
                  Map campo = snapshot2.value as Map;
                  campo['key'] = snapshot2.key;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UpdateCampo(
                            encuestaKey: widget.encuestaKey,
                            campoKey: campo['key'],
                          ),
                        ),
                      );
                      // print(Contact['key']);
                    },
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: const Color.fromARGB(255, 197, 216, 233),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[900],
                            ),
                            onPressed: () {
                              FirebaseDatabase.instance
                                  .ref("encuestas/${widget.encuestaKey}")
                                  .child(campo['key'])
                                  .remove();
                            },
                          ),
                          title: Text(
                            campo['nombreCampo'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            campo['titulo'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  update() async {
    try {
      if (nombreController.text != '') {
        Map<String, String> encuesta = {
          'nombre': nombreController.text,
          'descripcion': descripcionController.text,
          'codigo': codigo
        };

        dbRef!.child(widget.encuestaKey).update(encuesta).whenComplete(() {
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
