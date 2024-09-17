import 'package:flutter/material.dart';
import 'package:pelisflix/widgets/custom_bottom_nav_bar.dart';

class MyListsScreen extends StatefulWidget {
  @override
  _MyListsScreenState createState() => _MyListsScreenState();
}

class _MyListsScreenState extends State<MyListsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showCreateListDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    String? privacy = 'Private';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create New List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              DropdownButton<String>(
                value: privacy,
                onChanged: (String? newValue) {
                  setState(() {
                    privacy = newValue;
                  });
                },
                items: <String>['Public', 'Private'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text('Select Privacy'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String description = descriptionController.text;
                String privacyStatus = privacy ?? 'Private';

                // Aquí puedes agregar la lógica para guardar la nueva lista
                print('Name: $name');
                print('Description: $description');
                print('Privacy: $privacyStatus');

                Navigator.of(context).pop();
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi User!'),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(icon: Icon(Icons.person_outline), onPressed: () {}),
        ],
        bottom: TabBar(
          labelColor: Colors.red,
          indicatorColor: Colors.red,
          controller: _tabController,
          tabs: [
            Tab(text: 'List 1'),
            Tab(text: 'List 2'),
            Tab(text: 'List 3'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildListContent('List 1'),
          _buildListContent('List 2'),
          _buildListContent('List 3'),
        ],
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
              Navigator.pushNamed(context, '/activity');
              break;
            case 2:
            // Ya estamos en la pantalla de MyLists
              break;
            case 3:
              Navigator.pushNamed(context, '/search');
              break;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showCreateListDialog,
      ),
    );
  }

  Widget _buildListContent(String listName) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Title ipsum Lorem ipsum', style: TextStyle(fontWeight: FontWeight.bold)),
              Icon(Icons.more_vert),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('Nombre', style: TextStyle(fontSize: 12)),
                  Text('Puntuacion', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
