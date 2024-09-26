import 'package:flutter/material.dart';
import 'package:update_management/feature/force_update/strategies/min_tolerance_update_strategy_custom.dart';
import 'package:update_management/feature/force_update/strategies/update_strategy_default.dart';
import 'models/app_version.dart';
import 'models/update_info.dart';
import 'models/update_type.dart';
import 'services/version_check/version_check_service.dart';
import 'services/update_service.dart';
import 'strategies/update_strategy.dart';
import 'strategies/notused/forced_update_strategy.dart';
import 'strategies/notused/soft_update_strategy.dart';
import 'strategies/notused/min_tolerance_update_strategy.dart';
import 'utils/version_comparator.dart';

class ForceUpdateManager {
  final VersionCheckService versionCheckService;
  final UpdateService updateService;
  final AppVersion currentVersion;
  final AppVersion? minToleratedVersion;

  ForceUpdateManager({
    required this.versionCheckService,
    required this.updateService,
    required this.currentVersion,
    this.minToleratedVersion,
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
    // final forcedStrategy = ForcedUpdateStrategy(updateService);
    // final softStrategy = SoftUpdateStrategy(updateService);
    final updateStrategy = UpdateStrategyImpl(updateService);

    if (minToleratedVersion != null) {
      return MinToleranceUpdateStrategy(
        // forcedStrategy: forcedStrategy,
        // softStrategy: softStrategy,
        updateStrategy: updateStrategy,
        minToleratedVersion: minToleratedVersion!,
      );
    } else {
      return updateStrategy;
    }

    // switch (updateInfo.updateType) {
    //   case UpdateType.force:
    //     return forcedStrategy;
    //   case UpdateType.soft:
    //     return softStrategy;
    //   case UpdateType.none:
    //   default:
    //     return softStrategy;
    // }
  }
}
