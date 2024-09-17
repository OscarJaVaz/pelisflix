import 'package:flutter/material.dart';



class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // Controladores de texto para las contraseñas
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent[200], // Color de fondo similar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              child: Image.network(
                'https://survey.redplanetportal.com.au/Images/RPPforgotpw/Icons-20.png', // URL de la imagen
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Reestablece tu contraseña",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Ingresa una nueva contraseña",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(
                labelText: 'Crea nueva contraseña*',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirma tu contraseña*',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // agregar la lógica para verificar las contraseñas
                String newPassword = newPasswordController.text;
                String confirmPassword = confirmPasswordController.text;

                if (newPassword.isNotEmpty && newPassword == confirmPassword) {
                  // Acción cuando las contraseñas coinciden
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Éxito"),
                        content: const Text("Contraseña restablecida correctamente."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Aceptar"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Acción cuando las contraseñas no coinciden o están vacías
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: const Text("Las contraseñas no coinciden o están vacías."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Aceptar"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Color similar al botón
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Reestablecer'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Acción de cancelar
                Navigator.pushNamed(context, '/'); // Regresa a la pantalla anterior
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
