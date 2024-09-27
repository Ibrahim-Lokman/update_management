import 'package:flutter/material.dart';
import 'package:update_management/feature/force_update/models/update_type.dart';
import '../models/update_info.dart';
import '../models/app_version.dart';
import '../utils/version_comparator.dart';
import 'update_strategy.dart';

class MinToleranceUpdateStrategy implements UpdateStrategy {
  final UpdateStrategy updateStrategy;
  final AppVersion minToleratedVersion;

  MinToleranceUpdateStrategy({
    required this.updateStrategy,
    required this.minToleratedVersion,
  });

  @override
  Future<void> execute(BuildContext context, UpdateInfo updateInfo) async {
    print("minToleranceUpdateStrategy");
    print("updateInfo.latestVersion ${updateInfo.latestVersion}");
    print("minToleratedVersion $minToleratedVersion");
    print(
        "value diff ${VersionComparator.compare(updateInfo.latestVersion, minToleratedVersion)}");

    if (VersionComparator.isVersionBelowMinTolerance(
        updateInfo.latestVersion, minToleratedVersion)) {
      // Force update if the latest version is below the minimum tolerated version
      await updateStrategy.execute(
          context, updateInfo.copyWith(updateType: UpdateType.force));
    } else {
      // Regular update if the latest version is above or equal to the minimum tolerated version
      await updateStrategy.execute(context, updateInfo);
    }
  }
}
