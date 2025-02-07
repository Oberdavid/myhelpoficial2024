import 'package:firebase_auth/firebase_auth.dart';
import '../modelos/user_model.dart'; // Asegúrate de que este archivo exista
import 'firestore_service.dart';    // Asegúrate de que este archivo exista

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Registrar un usuario (app ciudadana)
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    List<Map<String, String>>? emergencyContacts, // Opcional
  }) async {
    try {
      // 1. Registrar usuario en Firebase Auth
      UserCredential userCredential = 
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

      // 2. Crear el modelo de usuario
      UserModel newUser = UserModel(
        userId: userCredential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        emergencyContacts: emergencyContacts ?? [], // Lista vacía si no se proporciona
      );

      // 3. Guardar datos adicionales en Firestore
      await _firestoreService.saveUser(newUser);

    } catch (e) {
      print("Error al registrar usuario: $e");
      throw e; // Relanza la excepción para manejarla en la UI
    }
  }
}