import 'package:url_launcher/url_launcher.dart';

class UpdateService {
  Future<void> performUpdate(String updateUrl) async {
    final Uri url = Uri.parse(updateUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $updateUrl';
    }
  }
}
