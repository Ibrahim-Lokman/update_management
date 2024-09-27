import 'package:flutter/material.dart';
import 'package:update_management/feature/force_update/models/update_info.dart';
import 'package:update_management/feature/force_update/ui/update_screen.dart';
import 'package:update_management/feature/force_update/services/version_check/version_check_service.dart';
import 'package:update_management/feature/force_update/services/update_service.dart';
import 'package:update_management/feature/force_update/ui/update_dialog.dart';

// Export UI components
export 'ui/update_dialog.dart';
export 'ui/update_screen.dart';

// Export models
export 'models/update_info.dart';

// Export services
export 'services/version_check/version_check_service.dart';
export 'services/update_service.dart';

class ForceUpdateManager {
  final VersionCheckService versionCheckService;
  final UpdateService updateService;
  final AppVersion currentVersion;

  ForceUpdateManager({
    required this.versionCheckService,
    required this.updateService,
    required this.currentVersion,
  });

  Future<void> checkForUpdates(BuildContext context) async {
    try {
      final updateInfo = await versionCheckService.checkVersion(currentVersion);
      final dialogType = _determineDialogType(updateInfo);
      if (dialogType != DialogType.none) {
        await _showUpdatePrompt(context, updateInfo, dialogType);
      }
    } catch (e) {
      print('Failed to check for updates: $e');
    }
  }

  DialogType _determineDialogType(UpdateInfo updateInfo) {
    final isCurrentOlderThanLatest =
        currentVersion.compareTo(updateInfo.latestVersion) < 0;
    final isCurrentOlderThanMinTolerated =
        currentVersion.compareTo(updateInfo.minToleratedVersion) < 0;

    if (isCurrentOlderThanMinTolerated) {
      return DialogType.force;
    } else if (isCurrentOlderThanLatest) {
      if (updateInfo.updateType == UpdateType.force) {
        return DialogType.force;
      } else if (updateInfo.updateType == UpdateType.soft ||
          updateInfo.updateType == UpdateType.none) {
        return DialogType.soft;
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
            onUpdate: () => updateService.performUpdate(updateInfo.updateUrl),
          ),
        ),
      );
    } else {
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => UpdateDialog(
          updateInfo: updateInfo,
          onUpdate: () => updateService.performUpdate(updateInfo.updateUrl),
          onLater: () => Navigator.of(context).pop(),
          isForceUpdate: false,
        ),
      );
    }
  }
}

enum DialogType {
  force,
  soft,
  none,
}

// Convenience function for quick setup
ForceUpdateManager setupForceUpdate({
  required VersionCheckService versionCheckService,
  required UpdateService updateService,
  required AppVersion currentVersion,
}) {
  return ForceUpdateManager(
    versionCheckService: versionCheckService,
    updateService: updateService,
    currentVersion: currentVersion,
  );
}

// Example usage function
void checkForUpdates(BuildContext context, ForceUpdateManager manager) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    manager.checkForUpdates(context);
  });
}
