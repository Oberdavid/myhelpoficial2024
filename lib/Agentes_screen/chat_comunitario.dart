// screens/sala_chat_comunitario.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:oficial_app/mensajes_screen/mensajes.dart';

class SalaChatComunitario extends StatefulWidget {
  final double radio;
  final LocationData ubicacionInicial;

  const SalaChatComunitario({
    Key? key,
    required this.radio,
    required this.ubicacionInicial,
  }) : super(key: key);

  @override
  _SalaChatComunitarioState createState() => _SalaChatComunitarioState();
}

class _SalaChatComunitarioState extends State<SalaChatComunitario> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late Stream<QuerySnapshot> _mensajesStream;
  bool _mostrarRespuestas = false;
  String? _chatRoomId;

  @override
  void initState() {
    super.initState();
    _initializeChatRoom();
  }

  void _initializeChatRoom() {
    _chatRoomId = DateTime.now().millisecondsSinceEpoch.toString();
    _mensajesStream = FirebaseFirestore.instance
        .collection('salas_chat')
        .doc(_chatRoomId)
        .collection('mensajes')
        .orderBy('timestamp', descending: true)
        .snapshots();

    _enviarMensajeInicial();
  }

  Future<void> _enviarMensajeInicial() async {
    if (_chatRoomId == null) return;

    final mensaje = Mensaje(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      texto:
          'Se solicita información sobre actividades sospechosas en esta área.',
      remitente: 'Policía',
      tipoRemitente: 'policia',
      timestamp: DateTime.now(),
      ubicacion: {
        'latitude': widget.ubicacionInicial.latitude,
        'longitude': widget.ubicacionInicial.longitude,
        'radio': widget.radio,
      },
    );

    await FirebaseFirestore.instance
        .collection('salas_chat')
        .doc(_chatRoomId)
        .collection('mensajes')
        .doc(mensaje.id)
        .set(mensaje.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat Comunitario',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(
                _mostrarRespuestas ? Icons.filter_list_off : Icons.filter_list),
            onPressed: () {
              setState(() {
                _mostrarRespuestas = !_mostrarRespuestas;
              });
            },
            tooltip: _mostrarRespuestas ? 'Mostrar todo' : 'Solo respuestas',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatusBar(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _mensajesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final mensajes = snapshot.data!.docs
                    .map((doc) =>
                        Mensaje.fromJson(doc.data() as Map<String, dynamic>))
                    .where((mensaje) =>
                        !_mostrarRespuestas ||
                        mensaje.tipoRemitente == 'ciudadano')
                    .toList();

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: mensajes.length,
                  itemBuilder: (context, index) {
                    final mensaje = mensajes[index];
                    return _buildMensajeWidget(mensaje);
                  },
                );
              },
            ),
          ),
          _buildInputChat(),
        ],
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.green.shade100,
      child: Row(
        children: [
          const Icon(Icons.radio_button_checked, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            'Radio de búsqueda: ${widget.radio} km',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMensajeWidget(Mensaje mensaje) {
    final isPolicia = mensaje.tipoRemitente == 'policia';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment:
            isPolicia ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isPolicia ? Colors.green.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: isPolicia
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    mensaje.remitente,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(mensaje.texto),
                  const SizedBox(height: 4),
                  Text(
                    _formatDateTime(mensaje.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputChat() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Escribe un mensaje...',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.green),
            onPressed: _enviarMensaje,
          ),
        ],
      ),
    );
  }

  void _enviarMensaje() async {
    if (_messageController.text.trim().isEmpty || _chatRoomId == null) return;

    final mensaje = Mensaje(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      texto: _messageController.text.trim(),
      remitente: 'Policía',
      tipoRemitente: 'policia',
      timestamp: DateTime.now(),
      ubicacion: {
        'latitude': widget.ubicacionInicial.latitude,
        'longitude': widget.ubicacionInicial.longitude,
      },
    );

    try {
      await FirebaseFirestore.instance
          .collection('salas_chat')
          .doc(_chatRoomId)
          .collection('mensajes')
          .doc(mensaje.id)
          .set(mensaje.toJson());

      _messageController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al enviar mensaje: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
