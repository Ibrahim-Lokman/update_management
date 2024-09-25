import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/app_version.dart';

class UpdateDialog {
  static const String ANDROID_STORE_URL =
      'https://play.google.com/store/apps/details?id=tech.innospace.brritto';
  // static const String IOS_STORE_URL = 'https://apps.apple.com/app/your-app-id';

  static void show(BuildContext context, AppVersion version) {
    showDialog(
      context: context,
      barrierDismissible: !version.forceUpdate,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Update Available'),
          content: Text(
              'Version ${version.version} is now available. Please update your app to continue using it.'),
          actions: <Widget>[
            if (!version.forceUpdate)
              TextButton(
                child: Text('Later'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            TextButton(
              child: Text('Update Now'),
              onPressed: () => _launchAppStore(context),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _launchAppStore(BuildContext context) async {
    final url = ANDROID_STORE_URL;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
