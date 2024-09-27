// Export UI components
export 'ui/update_dialog.dart';
export 'ui/update_screen.dart';

// Export strategies
export 'strategies/update_strategy.dart';
export 'strategies/notused/forced_update_strategy.dart';
export 'strategies/notused/soft_update_strategy.dart';
export 'strategies/notused/min_tolerance_update_strategy.dart';

// Export the main manager
export 'force_update_manager.dart';

// Convenience function for quick setup
import 'package:flutter/material.dart';
import 'force_update_manager.dart';
import 'services/version_check/version_check_service.dart';
import 'services/update_service.dart';
import 'models/app_version.dart';

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

// Example usage function
void checkForUpdates(BuildContext context, ForceUpdateManager manager) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    manager.checkForUpdates(context);
  });
}
