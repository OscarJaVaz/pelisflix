import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pelisflix/actors/popular_actors_grid_page.dart';
import 'package:pelisflix/main_screens/activity_screen.dart';
import 'package:pelisflix/main_screens/forgot_password.dart';
import 'package:pelisflix/main_screens/home_screen.dart';
import 'package:pelisflix/main_screens/login.dart';
import 'package:pelisflix/main_screens/my_lists.dart';
import 'package:pelisflix/main_screens/reset_password.dart';
import 'package:pelisflix/main_screens/search_screen.dart';
import 'package:pelisflix/movies/latest_trailers/latest_trailers_page.dart';
import 'package:pelisflix/movies/trending/all_trending_movies.dart';
import 'package:pelisflix/series/series_grid_page.dart';
import 'movies/movie_grid_page.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Pelisflix',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/login': (context) => Login(),
        '/grid': (context) => const MovieGridPage(),
        '/series': (context) => const SeriesGridPage(),
        '/forgotpassword': (context) => ForgotPasswordScreen(),
        '/resetpassword' : (context) => ResetPassword(),
        '/actors': (context) => const PopularActorsGrid(),
        '/trendingMovies': (context) => const AllTrendingMoviesPage(),
        '/latestTrailers': (context) => const LatestTrailersPage(),
        '/search': (context) => SearchScreen(),
        '/activity': (context) => ActivityScreen(),
        '/home': (context) => HomeScreen(),
        '/myList': (context) => MyListsScreen(),
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
    Future.delayed(Duration(seconds: 3), () {
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
