import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'encuestas/insert.dart';
import 'encuestas/update.dart';

class ListadoScreen extends StatefulWidget {
  const ListadoScreen({super.key});

  @override
  State<ListadoScreen> createState() => _ListadoScreenState();
}

class _ListadoScreenState extends State<ListadoScreen> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('encuestas');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const Ccreate(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text('Encuestas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          const SizedBox(height: 15.0),
          const Center(
            child: Text(
              'Listado de encuestas',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15.0),
          FirebaseAnimatedList(
            query: dbRef,
            shrinkWrap: true,
            itemBuilder: (context, snapshot, animation, index) {
              Map encuesta = snapshot.value as Map;
              encuesta['key'] = snapshot.key;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UpdateRecord(
                        encuestaKey: encuesta['key'],
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
                          dbRef.child(encuesta['key']).remove();
                        },
                      ),
                      title: Text(
                        encuesta['nombre'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        encuesta['codigo'],
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
        ]),
      ),
    );
  }
}
