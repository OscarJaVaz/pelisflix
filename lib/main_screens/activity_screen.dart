import 'package:flutter/material.dart';
import 'package:pelisflix/user/notifications_screen.dart';
import 'package:pelisflix/user/user_details.dart';
import 'package:pelisflix/widgets/custom_bottom_nav_bar.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _currentIndex = 1; // 1 para indicar que estamos en la pestaña de Actividad

  final List<Map<String, String>> activities = [
    {'message': '¡Nuevo episodio de tu serie favorita ya disponible!', 'time': 'Hace 1 hora'},
    {'message': 'La película "Inception" ha sido añadida a tu lista.', 'time': 'Hace 2 horas'},
    {'message': '¡El tráiler de la nueva película "Avatar" ya está disponible!', 'time': 'Hace 3 horas'},
    {'message': 'Tu película recomendada "Interstellar" está en tendencia.', 'time': 'Hace 5 horas'},
    {'message': 'La serie "Stranger Things" tiene nuevas reseñas.', 'time': 'Hace 8 horas'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi User!'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsScreen()),
            );},
          ),
          IconButton(
            icon: Icon(Icons.person_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserDetailsScreen()),
                );
              },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              title: Text(
                activities[index]['message']!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                activities[index]['time']!,
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                // Acción al tocar la notificación
                // Puedes implementar navegación o mostrar un diálogo, según el tipo de actividad
              },
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Actualizar el índice actual
          });
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
            // Ya estamos en la pantalla de Activity
              break;
            case 2:
              Navigator.pushNamed(context, '/myList');
              break;
            case 3:
              Navigator.pushNamed(context, '/search');
              break;
          }
        },
      ),
    );
  }
}
