import 'package:flutter/material.dart';
import 'package:prueba1/formulario/inicio_screen.dart';

class CodigoScreen extends StatefulWidget {
  const CodigoScreen({super.key});

  @override
  State<CodigoScreen> createState() => _CodigoScreenState();
}

class _CodigoScreenState extends State<CodigoScreen> {
  TextEditingController codigoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Código'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(children: [
          const SizedBox(height: 15.0),
          const Center(
            child: Text(
              'Ingrese el código de la encuesta',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 55.0),
          TextField(
            controller: codigoController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              hintText: "Código",
              prefixIcon:
                  Icon(Icons.border_color_outlined, color: Colors.black),
            ),
          ),
          const SizedBox(height: 60.0),
          SizedBox(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: Colors.blueAccent,
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InicioScreen(
                      codigo: codigoController.text,
                    ),
                  ),
                );
              },
              child: const Text('Ingresar',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ),
          ),
        ]),
      ),
    );
  }
}
