import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoglamour/user_auth/firebase_auth_services.dart';
import 'package:geoglamour/views/sign_up_auth.dart';
import 'package:geoglamour/widget/input_widget.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final bool _isSigning = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? mensaje;

  void notificacion(){
    setState(() {

    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 13, 15),
        automaticallyImplyLeading: false,
        leading: Icon(Icons.location_history_outlined),
        title: Text('Inicio de Sesión' ),
        
      ),

    body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical:70.0), // Ajusta el valor según sea necesario
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logon.png',
                    width: 250,
                    height: 250,
                  ),
                //Image.asset("images/user.png"),
                const SizedBox(
                  height: 60,
                ),
                _InputCustomized(_emailController,false,'Correo Electronico', 'E-mail', 
                TextInputType.emailAddress, Icons.email),
                const SizedBox(
                  height: 30,
                ),
                InputWidget(
                  controller: _passwordController,
                  hintText: 'Contraseña',
                  isPasswordField: true,
                  //inputType: TextInputType.visiblePassword ,
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: _signIn,
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 5, 6, 6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(child:Text("Inicio sesión",style: 
                    TextStyle(color: Color.fromARGB(255, 247, 243, 243),fontWeight: FontWeight.bold),)),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No tienes una cuenta?"),
                    const SizedBox(width: 5,),
                    GestureDetector(
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, 
                          MaterialPageRoute(builder: (context) => const SignUpPage()), 
                          (route) => false);
                        },
                        child: const Text("Registrarme",style: 
                        TextStyle(color: Color.fromARGB(255, 1, 5, 11),fontWeight: FontWeight.bold),)),
                        
                  ],
                ),
                const SizedBox(height: 25,),
                Text('$mensaje',
                style: const TextStyle(color: Colors.blue,
                fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ),
      ),
     ) );
  }

  void _signIn1() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null){
      print("Login Satisfactorio!!!");
      //Navigator.pushNamed(context, "/");
      Navigator.pushReplacementNamed(context, "/MapScreen");
    } else{
      //print("Some error happend");
    }
  }


  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null){
      print("Login Satisfactorio!!!");
      //Navigator.pushNamed(context, "/");
      Navigator.pushReplacementNamed(context, "/MapScreen");
      setState(() {
        mensaje = "";
      });
    } else{
      setState(() {
        mensaje = "No se encontro el usuario especificado";
      });
    }
  }


  //Creando widget con paso de parametros para personalizar
  Widget _InputCustomized(TextEditingController? controller, bool? isPassword, String? hintText, String? labelText, TextInputType? inputType, IconData? icon)
  {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.35),
        borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          controller: controller,
          keyboardType: inputType,
          obscureText: isPassword == true? true : false,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.black45
              ),
              suffixIcon: Icon(
                icon,
                color: Color.fromARGB(255, 235, 114, 169),
              )
            )
        ),
    );
  }



}