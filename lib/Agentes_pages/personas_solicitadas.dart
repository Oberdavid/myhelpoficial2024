import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WantedListScreen extends StatelessWidget {
  final List<Map<String, String>> wantedList = [
    {'id': '1', 'name': 'John Doe'},
    {'id': '2', 'name': 'Jane Smith'},
    // Agrega más personas según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personas Solicitadas',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.go('/authorityHome');
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: wantedList.length,
        itemBuilder: (context, index) {
          final person = wantedList[index];
          return ListTile(
            title: Text(person['name']!),
            onTap: () {
              context.go('/detallessolicitados/${person['id']}');
            },
          );
        },
      ),
    );
  }
}
