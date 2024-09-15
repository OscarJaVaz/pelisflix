import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pelisflix/screens/login.dart';
import 'package:pelisflix/screens/series_grid_page.dart';
import 'screens/movie_grid_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); //  inicializar Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pelisflix',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/grid': (context) => const MovieGridPage(),
        '/series': (context) => const SeriesGridPage(),
      },
      home: const SplashScreen(),
    );

  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 9), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPageWithBackground()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/intro.gif',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class LoginPageWithBackground extends StatelessWidget {
  const LoginPageWithBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://img.freepik.com/vector-premium/espacio-copia-pelicula-cine-sobre-concepto-pelicula-fondo-amarillo-video-cine_252172-126.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: const Login(),
      ),
    );
  }
}
