import 'package:flutter/material.dart';
import 'package:pelisflix/main_screens/home_screen.dart';
import 'package:pelisflix/main_screens/register.dart';
import 'package:pelisflix/main_screens/select_favorites.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  // Ocultar contraseña
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Mostrar diálogo de credenciales incorrectas
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

  // Mostrar el loading circle
  void showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false, // Impedir cerrar el diálogo al tocar afuera
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(), // Loading circle
        );
      },
    );
  }

  // Simular proceso de inicio de sesión con un delay de 2 segundos
  Future<void> _login() async {
    showLoadingIndicator();

    // Simular un proceso de autenticación de 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    // Cerrar el loading circle
    Navigator.of(context).pop();

    // Redirigir a HomeScreen después del delay
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SelectFavoritesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(46.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente
              crossAxisAlignment: CrossAxisAlignment.center, // Centra los elementos horizontalmente
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
                      color: Colors.black,
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
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.red,
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
                  onPressed: _login, // Llama al método _login al hacer clic
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black,
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
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("Regístrate aquí"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
