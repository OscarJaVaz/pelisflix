import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {/* acción de notificaciones */},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User', style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'oscar@gmail.com',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Member since'),
                  Spacer(),
                  Text('May 9'),
                  SizedBox(width: 8),
                  ElevatedButton(
                    child: Text('Share'),
                    onPressed: () {/* acción de compartir perfil */},
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Favorite Genres', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text('Action')),
                  Chip(label: Text('Comedy')),
                  Chip(label: Text('Drama')),
                  Chip(label: Text('Sci-Fi')),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Add new favorite genre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Save Changes'),
                onPressed: () {/* acción de guardar cambios */},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 36),
                ),
              ),
              SizedBox(height: 24),
              Text('Watch History', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 8),
              Row(
                children: [
                  Text('Recently Watched'),
                  Spacer(),
                  Text('3'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) =>
                    Container(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 100,
                      color: Colors.grey[300],
                      child: Center(child: Text('Movie ${index + 1}')),
                    )
                ),
              ),
              SizedBox(height: 16),
              Text('My Ratings', style: Theme.of(context).textTheme.titleMedium),
              ListTile(
                title: Text('Average Rating'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    Text('4.5'),
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