import 'package:url_launcher/url_launcher.dart';

class AlertService {
  Future<void> sendAlert(String phoneNumber, String message) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {'body': message},
    );

    if (await canLaunch(smsUri.toString())) {
      await launch(smsUri.toString());
    } else {
      throw 'No se pudo enviar el mensaje';
    }
  }
}