import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../servicios/firestore_service.dart';
import '../modelos/publicacion_model.dart';

class PublicacionScreen extends StatefulWidget {
  const PublicacionScreen({Key? key}) : super(key: key);

  @override
  _PublicacionScreenState createState() => _PublicacionScreenState();
}

class _PublicacionScreenState extends State<PublicacionScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  String _tipoSeleccionado = 'persona'; // Categoría por defecto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Publicación')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de título
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 16),

            // Campo de descripción
            TextFormField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 16),

            // Selector de categoría
            DropdownButton<String>(
              value: _tipoSeleccionado,
              items: const [
                DropdownMenuItem(value: 'persona', child: Text('Persona')),
                DropdownMenuItem(value: 'vehiculo', child: Text('Vehículo')),
                DropdownMenuItem(value: 'mascota', child: Text('Mascota')),
                DropdownMenuItem(value: 'documento', child: Text('Documento')),
              ],
              onChanged: (value) {
                setState(() {
                  _tipoSeleccionado = value!;
                });
              },
            ),
            const SizedBox(height: 24),

            // Botón para guardar
            ElevatedButton(
              onPressed: _guardarPublicacion,
              child: const Text('Guardar Publicación'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _guardarPublicacion() async {
    // Datos específicos de la categoría seleccionada
    Map<String, dynamic> detalles = {};
    switch (_tipoSeleccionado) {
      case 'persona':
        detalles = {
          'nombre': 'Juan Pérez',
          'edad': 25,
          'genero': 'masculino',
          'altura': '1.75 m',
          'ultimaVisto': 'Centro Comercial',
        };
        break;
      case 'vehiculo':
        detalles = {
          'marca': 'Toyota',
          'modelo': 'Corolla',
          'color': 'Rojo',
          'placa': 'ABC-123',
        };
        break;
      // Agrega más casos para otras categorías...
    }

    // Crear el objeto de la publicación
    PublicacionExtraviado publicacion = PublicacionExtraviado(
      titulo: _tituloController.text,
      descripcion: _descripcionController.text,
      tipo: _tipoSeleccionado,
      fechaPublicacion: DateTime.now(),
      usuarioId: 'abc123', // Reemplaza con el ID del usuario autenticado
      detalles: detalles, publicacionId: '',
    );

    // Guardar en Firestore
    await _firestoreService.guardarPublicacion(publicacion);

    // Limpiar campos
    _tituloController.clear();
    _descripcionController.clear();

    // Mostrar mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Publicación guardada correctamente')),
    );
  }
}