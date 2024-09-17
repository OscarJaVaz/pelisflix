import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pelisflix/screens/home_screen.dart';
import 'package:pelisflix/screens/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;


  //ocultar contraseña
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void showIncorrectCredentialsAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Credenciales incorrectas'),
          content: const Text('El correo electrónico o la contraseña son incorrectos.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: const Text('Pelisflix'),
          backgroundColor: Colors.red
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://cdn.icon-icons.com/icons2/1508/PNG/512/systemusers_104569.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      borderSide: const BorderSide(
                        color: Colors.red, // Color del borde cuando el campo no está enfocado
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  cursorColor: Colors.red,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),


                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.red,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      borderSide: const BorderSide(
                        color: Colors.red, // Color del borde cuando el campo no está enfocado
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),

                  ),
                  obscureText: _obscureText,
                  cursorColor: Colors.red,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()), // Navega a HomeScreen
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
                  child: const Text('Iniciar sesión'),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Redirigir a una nueva vista
                      Navigator.pushNamed(context, '/forgotpassword');
                    },
                    child: const Text(
                      "Olvidó su contraseña?",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "¿Usuario nuevo?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Register()),
                            );
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                          ),
                          child: const Text("Regístrate aquí"),
                        ),

                      ],
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'o continúa con',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement Google sign-in functionality
                        },
                        icon: const Icon(Icons.email),
                        label: const Text('Iniciar sesión con Google'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement Facebook sign-in functionality
                        },
                        icon: const Icon(Icons.facebook),
                        label: const Text('Iniciar sesión con Facebook'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          onPrimary: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
