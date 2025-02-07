class UserModel {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final List<Map<String, String>> emergencyContacts;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    this.emergencyContacts = const [], // Lista vacía por defecto
  });

  // Convertir UserModel → Map (para Firestore)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'emergencyContacts': emergencyContacts,
    };
  }

  // Convertir Firestore → UserModel
  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      userId: data['userId'] ?? '', // Valor por defecto si es nulo
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      emergencyContacts: List<Map<String, String>>.from(
        data['emergencyContacts'] ?? [], // Lista vacía si es nulo
      ),
    );
  }
}