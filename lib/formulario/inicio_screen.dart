import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class InicioScreen extends StatefulWidget {
  final String codigo;
  const InicioScreen({super.key, required this.codigo});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('encuestas');
  @override
  void initState() {
    super.initState();
    encuestaData();
  }

  void encuestaData() async {
    final snapshot =
        await databaseReference.orderByValue().equalTo(widget.codigo).get();
    print(snapshot.value);
    Map encuesta = snapshot.value as Map;
    print(encuesta);
    setState(() {
      //if (encuesta['codigo'] == widget.codigo)
      {
        nombreController.text = encuesta['nombre'];
        descripcionController.text = encuesta['descripcion'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70.0),
            Center(
              child: Text(
                nombreController.text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 55.0),
            Text(
              descripcionController.text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
