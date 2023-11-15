// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/codigo_screen.dart';
import 'package:prueba1/listado_screen.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prueba Dev Sis',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Función
  static Future<User?> loginEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Usuario no encontrado para este correo");
      }
    } catch (e) {
      print(e.toString());
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: [
            const SizedBox(height: 70.0),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Chamitos app',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 55.0),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Nombre usuario",
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 26.0),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Contraseña",
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 88.0),
                  SizedBox(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: Colors.blue,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        User? user = await loginEmailPassword(
                            email: emailController.text.toString().trim(),
                            password: passwordController.text.toString().trim(),
                            context: context);
                        print(user);
                        if (user != null) {
                          navigator.push(
                            MaterialPageRoute(
                                builder: (context) => const ListadoScreen()),
                          );
                        }
                      },
                      child: const Text('Ingresar',
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0)),
                    ),
                  ),
                  const SizedBox(height: 120.0),
                  SizedBox(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: Colors.blueGrey,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CodigoScreen()));
                      },
                      child: const Text('Ingresar código',
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.0)),
                    ),
                  )
                ]),
          ])),
    );
  }
}
