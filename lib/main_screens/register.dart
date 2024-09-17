import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Por favor, ingresa tus datos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _userController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: const TextStyle(color: Colors.red),
                cursorColor: Colors.red,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: const TextStyle(color: Colors.red),
                cursorColor: Colors.red,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration:  InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.red,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: const TextStyle(color: Colors.red),
                cursorColor: Colors.red,
                obscureText: _obscureText,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _password2Controller,
                decoration: InputDecoration(
                  labelText: 'Confirma tu contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText2 ? Icons.visibility : Icons.visibility_off, color: Colors.red,
                    ),
                    onPressed: _togglePasswordVisibility2,
                  ),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                style: const TextStyle(color: Colors.red),
                cursorColor: Colors.red,
                obscureText: _obscureText2,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.red,
                                size: 40,
                              ),
                              SizedBox(width: 10),
                              Text('Registro Exitoso'),
                            ],
                          ),
                          content: const Text('Te has registrado correctamente.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK',style: TextStyle(color: Colors.red),),

                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black,
                  ),
                  child: const Text('Crear cuenta'),
                ),
              ),
              const SizedBox(height: 20,
              ),

              Center(
                child: Column(
                  children: [
                    const Text(
                      'o continúa con',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement Google sign-in functionality
                      },
                icon: const Icon(Icons.email),
                label: const Text('Registrarse con Google'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue,
                ),
              ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              // Implement Facebook sign-in functionality
            },
            icon: const Icon(Icons.facebook), // Use Facebook logo icon if available
            label: const Text('Registrarse con Facebook'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
            ),
          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
