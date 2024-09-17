import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent[200], // Color de fondo similar
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente
            crossAxisAlignment: CrossAxisAlignment.center, // Centra los elementos horizontalmente
            children: [
              Container(
                width: 100,
                height: 100,
                child: Image.network(
                  'https://parspng.com/wp-content/uploads/2023/03/emailpng.parspng.com-3.png', // URL de la imagen
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                'Introduce tu correo electrónico para restablecer la contraseña:',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center, // Alinea el texto al centro
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String email = emailController.text;
                  if (email.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Código enviado'),
                          content: Text(
                            'Se ha enviado el código para restablecer su contraseña a $email.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Cierra el diálogo
                                Navigator.pushNamed(context, '/resetpassword'); // Redirige a /resetpassword
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Por favor, introduce tu correo electrónico.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Cierra el diálogo
                                Navigator.pushNamed(context, '/resetpassword'); // Redirige a /resetpassword
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.red,
                              ),
                              child: const Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                ),
                child: const Text('Enviar código'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
