import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoglamour/user_auth/firebase_auth_services.dart';
import 'package:geoglamour/views/login_page.dart';
import 'package:geoglamour/widget/input_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 12, 15),
        leading: Icon(Icons.add_reaction_sharp),
        title: const Text("Registrarse"),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "",
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 5, 7, 7)),
                  ),
                  Image.asset(
                    'assets/logon.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputWidget(
                    controller: _usernameController,
                    hintText: "Nombre de Usuario",
                    isPasswordField: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputWidget(
                    controller: _emailController,
                    hintText: "Dirección de correo",
                    isPasswordField: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputWidget(
                    controller: _passwordController,
                    hintText: "Contraseña",
                    isPasswordField: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: _signUp,
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 8, 9, 9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        "Registrarme",
                        style: TextStyle(
                            color: Color.fromARGB(255, 249, 248, 248),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Ya tienes cuenta?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Color.fromARGB(255, 68, 166, 241),
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        print("Usuario agregado satisfactoriamente.");
        Navigator.pushNamed(context, "/login");
      } else {
        print("No se pudo registrar al usuario.");
      }
    } catch (e) {
      print("Error durante el registro: $e");
      // Puedes mostrar el error al usuario o realizar acciones adicionales según tus necesidades.
    }
  }
}
