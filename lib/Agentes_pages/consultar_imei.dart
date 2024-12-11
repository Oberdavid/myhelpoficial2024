import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConsultarImeiScreen extends StatefulWidget {
  @override
  _ConsultarImeiScreenState createState() => _ConsultarImeiScreenState();
}

class _ConsultarImeiScreenState extends State<ConsultarImeiScreen> {
  final TextEditingController _imeiController = TextEditingController();
  String _filter = 'Todas';
  List<Map<String, dynamic>> _resultados = [];
  bool _isLoading = false;

  void _consultarImei() async {
    setState(() {
      _isLoading = true;
    });

    // Aquí llamarías a la API para consultar el IMEI
    // Simularemos los resultados de la API con datos ficticios

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _resultados = [
        {
          'imei': '123456789012345',
          'estado': 'Valido',
          'ubicacion': 'Bogotá, Colombia',
          'propietario': 'Juan Pérez',
        },
        {
          'imei': '987654321098765',
          'estado': 'Reportado Robado',
          'ubicacion': 'Medellín, Colombia',
          'propietario': 'María López',
        },
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consultar IMEI',
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
            context.go('authorityHome');
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _imeiController,
              decoration: InputDecoration(
                labelText: 'Ingrese el IMEI',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _consultarImei,
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _filter,
              onChanged: (value) {
                setState(() {
                  _filter = value!;
                });
              },
              items: <String>['Todas', 'Valido', 'Reportado Robado']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _resultados.length,
                      itemBuilder: (context, index) {
                        final resultado = _resultados[index];
                        if (_filter == 'Todas' ||
                            _filter == resultado['estado']) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'IMEI: ${resultado['imei']}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('Estado: ${resultado['estado']}'),
                                  const SizedBox(height: 8),
                                  Text('Ubicación: ${resultado['ubicacion']}'),
                                  const SizedBox(height: 8),
                                  Text(
                                      'Propietario: ${resultado['propietario']}'),
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ConsultarImeiScreen(),
  ));
}
