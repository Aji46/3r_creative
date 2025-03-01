import 'package:url_launcher/url_launcher.dart';

whatsapp() async {
  String contact = "+91971585023411";
  String text = Uri.encodeComponent("Hi, how are you?");
  String androidUrl = "whatsapp://send?phone=$contact&text=$text";
  String iosUrl = "https://wa.me/$contact?text=$text";
  String webUrl = 'https://api.whatsapp.com/send/?phone=$contact&text=$text';

  try {
  
      if (await canLaunchUrl(Uri.parse(androidUrl))) {
        await launchUrl(Uri.parse(androidUrl), mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
      }
    
  } catch (e) {
    print("Error: $e");
    await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
  }
}
