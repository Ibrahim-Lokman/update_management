import 'package:flutter/material.dart';
import 'package:update_management/feature/force_update/strategies/min_tolerance_update_strategy_custom.dart';
import 'package:update_management/feature/force_update/strategies/update_strategy_default.dart';
import 'models/app_version.dart';
import 'models/update_info.dart';
import 'services/version_check/version_check_service.dart';
import 'services/update_service.dart';
import 'strategies/update_strategy.dart';
import 'utils/version_comparator.dart';

class ForceUpdateManager {
  final VersionCheckService versionCheckService;
  final UpdateService updateService;
  final AppVersion currentVersion;
  final AppVersion minToleranceVersion;

  ForceUpdateManager({
    required this.versionCheckService,
    required this.updateService,
    required this.currentVersion,
    required this.minToleranceVersion,
  });

  Future<void> checkForUpdates(BuildContext context) async {
    try {
      final updateInfo = await versionCheckService.checkVersion(currentVersion);
      print("updateInfo $updateInfo");
      if (VersionComparator.isUpdateRequired(
          currentVersion, updateInfo.latestVersion)) {
        final strategy = _getUpdateStrategy(updateInfo);
        await strategy.execute(context, updateInfo);
      }
    } catch (e) {
      print('Failed to check for updates: $e');
    }
  }

  UpdateStrategy _getUpdateStrategy(UpdateInfo updateInfo) {
    final updateStrategy = UpdateStrategyImpl(updateService);

    return MinToleranceUpdateStrategy(
      updateStrategy: updateStrategy,
      minToleratedVersion: minToleranceVersion,
    );
  }
}

ForceUpdateManager setupForceUpdate({
  required VersionCheckService versionCheckService,
  required UpdateService updateService,
  required AppVersion currentVersion,
  required AppVersion minToleranceVersion,
}) {
  return ForceUpdateManager(
    versionCheckService: versionCheckService,
    updateService: updateService,
    currentVersion: currentVersion,
    minToleranceVersion: minToleranceVersion,
  );
}

void checkForUpdates(BuildContext context, ForceUpdateManager manager) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    manager.checkForUpdates(context);
  });
}
