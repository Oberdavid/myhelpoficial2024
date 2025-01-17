import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}

class ReportarDesaparecidoScreen extends StatefulWidget {
  @override
  _ReportarDesaparecidoScreenState createState() =>
      _ReportarDesaparecidoScreenState();
}

class _ReportarDesaparecidoScreenState
    extends State<ReportarDesaparecidoScreen> {
  String _selectedCategory = '';
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _fechaController = TextEditingController();
  TextEditingController _horaController = TextEditingController();
  File? _image;
  bool _ofreceRecompensa = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _reportarDesaparecido() {
    print('Categoría seleccionada: $_selectedCategory');
    print('Descripción: ${_descripcionController.text}');
    print('Fecha: ${_fechaController.text}');
    print('Hora: ${_horaController.text}');
    print('Imagen: ${_image?.path}');
    print('Ofrece recompensa: $_ofreceRecompensa');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reportar Desaparecido',
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
          onPressed: () {
            context.go('/casascreen');
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedCategory.isEmpty ? null : _selectedCategory,
              hint: const Text('Seleccione la categoría'),
              items: const [
                DropdownMenuItem(
                  child: Text('Personas'),
                  value: 'Personas',
                ),
                DropdownMenuItem(
                  child: Text('Vehículos'),
                  value: 'Vehículos',
                ),
                DropdownMenuItem(
                  child: Text('Mascotas'),
                  value: 'Mascotas',
                ),
                DropdownMenuItem(
                  child: Text('Documentos'),
                  value: 'Documentos',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value ?? '';
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _fechaController,
              decoration: const InputDecoration(labelText: 'Fecha'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _horaController,
              decoration: const InputDecoration(labelText: 'Hora'),
            ),
            const SizedBox(height: 10),
            _image == null
                ? TextButton(
                    onPressed: _pickImage,
                    child: const Text('Subir Imagen de Referencia'),
                  )
                : Image.file(_image!),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ofrece Recompensa'),
                Switch(
                  value: _ofreceRecompensa,
                  onChanged: (value) {
                    setState(() {
                      _ofreceRecompensa = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _reportarDesaparecido,
              child: const Text('Reportar'),
            ),
          ],
        ),
      ),
    );
  }
}
