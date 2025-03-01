import 'package:url_launcher/url_launcher.dart';

void dialNumber(String phoneNumber) async {
  final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunchUrl(telUri)) {
    await launchUrl(telUri, mode: LaunchMode.externalApplication);
  } else {
    print("Could not launch dialer");
  }
}
