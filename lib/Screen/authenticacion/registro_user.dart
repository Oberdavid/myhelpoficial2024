import 'package:firebase_auth/firebase_auth.dart';
import 'package:oficial_app/Servicios/firestore_service.dart';
import 'package:oficial_app/modelos/user_model.dart';

void registerUser(String email, String password, String name, String phone) async {
  try {
    // Crear usuario en Firebase Auth
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Guardar datos en Firestore
    UserModel newUser = UserModel(
      userId: userCredential.user!.uid,
      name: name,
      email: email,
      phone: phone,
      emergencyContacts: [], // Inicialmente vacío
    );

    FirestoreService().saveUser(newUser);
    print("Usuario registrado exitosamente");
  } catch (e) {
    print("Error: $e");
  }
}