import 'package:firebase_auth/firebase_auth.dart';
import 'package:oficial_app/Servicios/firestore_service.dart';
import 'package:oficial_app/modelos/policias_model.dart';

void registerPolice(String email, String password, String badgeNumber, String name) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    PoliceModel newPolice = PoliceModel(
      policeId: userCredential.user!.uid,
      badgeNumber: badgeNumber,
      name: name,
      email: email,
      phone: "", // El policía puede completarlo luego
      department: "Policía Nacional",
      assignedZone: "Zona Centro",
    );

    FirestoreService().savePolice(newPolice);
    print("Policía registrado exitosamente");
  } catch (e) {
    print("Error: $e");
  }
}