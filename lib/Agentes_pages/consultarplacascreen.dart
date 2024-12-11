import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConsultarPlacaScreen extends StatefulWidget {
  @override
  _ConsultarPlacaScreenState createState() => _ConsultarPlacaScreenState();
}

class _ConsultarPlacaScreenState extends State<ConsultarPlacaScreen> {
  final TextEditingController _placaController = TextEditingController();
  String _filter = 'Todas';
  List<Map<String, dynamic>> _resultados = [];
  bool _isLoading = false;

  void _consultarPlaca() async {
    setState(() {
      _isLoading = true;
    });

    // Aquí llamarías a la API de la policía nacional
    // Simularemos los resultados de la API con datos ficticios

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _resultados = [
        {
          'placa': 'ABC123',
          'estado': 'Activa',
          'multas': 2,
          'historial': 'Sin incidentes graves.',
        },
        {
          'placa': 'XYZ987',
          'estado': 'Suspendida',
          'multas': 5,
          'historial': 'Varias infracciones de tráfico.',
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
          'Consultar Placa',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _placaController,
              decoration: InputDecoration(
                labelText: 'Ingrese la matrícula',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _consultarPlaca,
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
              items: <String>['Todas', 'Activa', 'Suspendida']
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
                                    'Placa: ${resultado['placa']}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('Estado: ${resultado['estado']}'),
                                  const SizedBox(height: 8),
                                  Text('Multas: ${resultado['multas']}'),
                                  const SizedBox(height: 8),
                                  Text('Historial: ${resultado['historial']}'),
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
