class PoliceModel {
  final String policeId;
  final String badgeNumber;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String assignedZone;

  PoliceModel({
    required this.policeId,
    required this.badgeNumber,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.assignedZone,
  });

  // Convertir Firestore → PoliceModel
  factory PoliceModel.fromFirestore(Map<String, dynamic> data) {
    return PoliceModel(
      policeId: data['policeId'],
      badgeNumber: data['badgeNumber'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      department: data['department'],
      assignedZone: data['assignedZone'],
    );
  }
}
