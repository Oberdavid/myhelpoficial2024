import 'package:cloud_firestore/cloud_firestore.dart';

class PublicacionExtraviado {
  final String publicacionId;
  final String tipo;
  final String titulo;
  final String descripcion;
  final DateTime fechaPublicacion;
  final String usuarioId;
  final String? categoria;
  final String? imagenUrl;
  final Map<String, dynamic>? ubicacion;
  final Map<String, dynamic> detalles;
  final String estado;
  final double? recompensa;

  PublicacionExtraviado({
    required this.publicacionId,
    required this.tipo,
    required this.titulo,
    required this.descripcion,
    required this.fechaPublicacion,
    required this.usuarioId,
    this.categoria,
    this.imagenUrl,
    this.ubicacion,
    required this.detalles,
    this.estado = "activo",
    this.recompensa,
  });

  // Convertir a Map para Firestore
  Map<String, dynamic> toMap() {
    return {
      'publicacionId': publicacionId,
      'tipo': tipo,
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaPublicacion': Timestamp.fromDate(fechaPublicacion),
      'usuarioId': usuarioId,
      'categoria': categoria,
      'imagenUrl': imagenUrl,
      'ubicacion': ubicacion,
      'detalles': detalles,
      'estado': estado,
      'recompensa': recompensa,
    };
  }

  // Convertir Firestore → PublicacionExtraviado
  // En modelos/publicacion_model.dart
factory PublicacionExtraviado.fromFirestore(DocumentSnapshot doc) {
  // Obtener los datos del documento
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>; {
    return PublicacionExtraviado(
      publicacionId: data['publicacionId'],
      tipo: data['tipo'],
      titulo: data['titulo'],
      descripcion: data['descripcion'],
      fechaPublicacion: (data['fechaPublicacion'] as Timestamp).toDate(),
      usuarioId: data['usuarioId'],
      categoria: data['categoria'],
      imagenUrl: data['imagenUrl'],
      ubicacion: data['ubicacion'],
      detalles: data['detalles'],
      estado: data['estado'],
      recompensa: data['recompensa'],
    );
  }
}
}
