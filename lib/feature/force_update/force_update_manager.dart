import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:update_management/feature/force_update/models/update_info.dart';
import 'package:update_management/feature/force_update/ui/update_screen.dart';
import 'package:update_management/feature/force_update/services/version_check/api_version_check.dart';
import 'package:update_management/feature/force_update/ui/update_dialog.dart';

class ForceUpdateManager {
  static ForceUpdateManager? _instance;
  final VersionCheckService versionCheckService;
  final AppVersion currentVersion;

  ForceUpdateManager._({
    required this.versionCheckService,
    required this.currentVersion,
  });

  static ForceUpdateManager get instance {
    if (_instance == null) {
      throw Exception(
          "ForceUpdateManager not initialized. Call initializeForceUpdateManager() first.");
    }
    return _instance!;
  }

  Future<void> checkForUpdates(BuildContext context) async {
    try {
      final updateInfo = await versionCheckService.checkVersion(currentVersion);
      final dialogType = determineDialogType(updateInfo);
      if (dialogType != DialogType.none) {
        await _showUpdatePrompt(context, updateInfo, dialogType);
      }
    } catch (e) {
      print('Failed to check for updates: $e');
    }
  }

  DialogType determineDialogType(UpdateInfo updateInfo) {
    if (updateInfo.minToleratedVersion != null &&
        currentVersion.compareTo(updateInfo.minToleratedVersion!) < 0) {
      return DialogType.force;
    }

    if (updateInfo.latestVersion == null) {
      return DialogType.none;
    }

    final isCurrentOlderThanLatest =
        currentVersion.compareTo(updateInfo.latestVersion!) < 0;

    if (isCurrentOlderThanLatest) {
      switch (updateInfo.updateType) {
        case UpdateType.force:
          return DialogType.force;
        case UpdateType.soft:
          return DialogType.soft;
        case UpdateType.none:
        case null:
          return DialogType.none;
      }
    }

    return DialogType.none;
  }

  Future<void> _showUpdatePrompt(BuildContext context, UpdateInfo updateInfo,
      DialogType dialogType) async {
    final isForceUpdate = dialogType == DialogType.force;

    if (isForceUpdate) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ForceUpdateScreen(
            updateInfo: updateInfo,
            onUpdate: () => performUpdate(context, updateInfo.updateUrl),
          ),
        ),
      );
    } else {
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => UpdateDialog(
          updateInfo: updateInfo,
          onUpdate: () => performUpdate(context, updateInfo.updateUrl),
          onLater: () => Navigator.of(context).pop(),
          isForceUpdate: false,
        ),
      );
    }
  }

  Future<void> performUpdate(BuildContext context, String? updateUrl) async {
    if (updateUrl == null) {
      // Show SnackBar using the passed BuildContext
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Try Again Later.'),
        ),
      );
    } else {
      final Uri url = Uri.parse(updateUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $updateUrl';
      }
    }
  }
}

enum DialogType {
  force,
  soft,
  none,
}

Future<void> checkForUpdates(BuildContext context) async {
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = AppVersion.fromString(packageInfo.version);

  final apiVersionCheck =
      ApiVersionCheck('https://your-api-endpoint.com/version');

  ForceUpdateManager._instance = ForceUpdateManager._(
    versionCheckService: apiVersionCheck,
    currentVersion: currentVersion,
  );
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ForceUpdateManager.instance.checkForUpdates(context);
  });
}
