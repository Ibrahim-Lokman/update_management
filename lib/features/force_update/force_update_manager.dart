import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'services/firebase_service.dart';
import 'utils/version_utils.dart';
import 'update_dialog.dart';

class ForceUpdateManager {
  static Future<void> checkForUpdate(BuildContext context) async {
    print("ForceUpdateManager");
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      print("currentVersion $currentVersion");

      final latestVersion = await FirebaseService.getLatestVersion();
      print("latestVersion $latestVersion");
      if (latestVersion != null &&
          VersionUtils.isVersionNewer(currentVersion, latestVersion.version)) {
        UpdateDialog.show(context, latestVersion);
      }
    } catch (e) {
      print('Error checking for updates: $e');
    }
  }
}
