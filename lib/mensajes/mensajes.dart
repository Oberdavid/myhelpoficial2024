// models/mensaje.dart
class Mensaje {
  final String id;
  final String texto;
  final String remitente;
  final String tipoRemitente;
  final DateTime timestamp;
  final Map<String, dynamic>? ubicacion;

  Mensaje({
    required this.id,
    required this.texto,
    required this.remitente,
    required this.tipoRemitente,
    required this.timestamp,
    this.ubicacion,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'texto': texto,
    'remitente': remitente,
    'tipoRemitente': tipoRemitente,
    'timestamp': timestamp.toIso8601String(),
    'ubicacion': ubicacion,
  };

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
    id: json['id'] as String,
    texto: json['texto'] as String,
    remitente: json['remitente'] as String,
    tipoRemitente: json['tipoRemitente'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
    ubicacion: json['ubicacion'] as Map<String, dynamic>?,
  );
}