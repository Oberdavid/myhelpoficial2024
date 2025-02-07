import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/user_model.dart';
import '../modelos/policias_model.dart';
import '../modelos/publicacion_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Guardar usuario en Firestore
  Future<void> saveUser(UserModel user) async {
    await _firestore.collection('users').doc(user.userId).set({
      'userId': user.userId,
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
    });
  }

  // Guardar policía en Firestore
  Future<void> savePolice(PoliceModel police) async {
    await _firestore.collection('police').doc(police.policeId).set({
      'policeId': police.policeId,
      'badgeNumber': police.badgeNumber,
      'name': police.name,
      'email': police.email,
      'department': police.department,
    });
  }
 // Guardar una publicación
  Future<void> guardarPublicacion(PublicacionExtraviado publicacion) async {
    await _firestore.collection('publicaciones_extraviados').add(publicacion.toMap());
  }

  // Recuperar todas las publicaciones
  Stream<List<PublicacionExtraviado>> obtenerPublicaciones() {
    return _firestore.collection('publicaciones_extraviados').snapshots().map(
      (snapshot) => snapshot.docs.map(
        (doc) => PublicacionExtraviado.fromFirestore(doc),
      ).toList(),
    );
  }

  // Recuperar publicaciones por categoría
Stream<List<PublicacionExtraviado>> obtenerPublicacionesPorCategoria() {
  return FirebaseFirestore.instance
      .collection('publicaciones_extraviados')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => PublicacionExtraviado.fromFirestore(doc)) // <- Pasar solo doc
          .toList());
}
}



