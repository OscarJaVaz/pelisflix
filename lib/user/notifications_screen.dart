import 'package:flutter/material.dart';
import 'package:pelisflix/user/user_details.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {'message': 'Nueva pelicula.', 'time': '8 hrs'},
    {'message': 'Nueva serie.', 'time': '1 day'},
    {'message': 'Grandes estrenos.', 'time': '5 days'},
    {'message': 'Las peliculas de accion te caerian bien.', 'time': '18/04'},
    {'message': 'Recomendaciones de la semana.', 'time': '18/04'},
    {'message': 'Novedades.', 'time': '18/04'},
    {'message': 'Porque viste esto...', 'time': '18/04'},
    {'message': 'Echale un vistazo a..', 'time': '10/04'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Notifications'),
        actions: [
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
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              title: Text(
                notifications[index]['message']!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                notifications[index]['time']!,
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                _showNotificationDetails(
                  context,
                  notifications[index]['message']!,
                  notifications[index]['time']!,
                );
              },
            ),
          );
        },
      ),
    );
  }

  // Función para mostrar el detalle de la notificación
  void _showNotificationDetails(BuildContext context, String message, String time) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification Detail'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Received: $time',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
