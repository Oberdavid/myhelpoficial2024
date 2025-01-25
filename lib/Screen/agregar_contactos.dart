import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<Map<String, String>> contacts = [];

  void _addContact() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        contacts.add({
          'name': _nameController.text,
          'phone': _phoneController.text,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contacto agregado exitosamente!')),
      );

      _nameController.clear();
      _phoneController.clear();
    }
  }

  void _callContact(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'No se pudo realizar la llamada a $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: ClipPath(
          clipper: _AppBarClipper(),
          child: AppBar(
            title: const Text(
              'Agregar Contáctos',
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              color: Colors.white,
              onPressed: () {
                context.go('/casascreen');
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset('assets/logo.jpg', height: 100),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration:
                    const InputDecoration(labelText: 'Nombre del Contacto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del contacto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration:
                    const InputDecoration(labelText: 'Número de Teléfono'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el número de teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _addContact,
                child: const Text('Agregar Contacto'),
              ),
              const SizedBox(height: 30),
              const Text(
                'Contactos Guardados:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return ListTile(
                      title: Text(contact['name']!),
                      subtitle: Text(contact['phone']!),
                      trailing: IconButton(
                        icon: const Icon(Icons.call),
                        onPressed: () => _callContact(contact['phone']!),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 2, size.height - 50, size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
