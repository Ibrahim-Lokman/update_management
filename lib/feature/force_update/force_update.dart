export 'models/app_version.dart';
export 'models/update_info.dart';
export 'models/update_type.dart';

// Export services
export 'services/version_check/version_check_service.dart';
export 'services/version_check/firebase_version_check.dart';
export 'services/version_check/api_version_check.dart';
export 'services/update_service.dart';

// Export utils
export 'utils/version_comparator.dart';
export 'utils/update_urgency_calculator.dart';

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

// Optionally, you can provide a convenience function for quick setup
import 'package:flutter/material.dart';
import 'force_update_manager.dart';
import 'services/version_check/version_check_service.dart';
import 'services/update_service.dart';
import 'models/app_version.dart';

ForceUpdateManager setupForceUpdate({
  required VersionCheckService versionCheckService,
  required UpdateService updateService,
  required AppVersion currentVersion,
  AppVersion? minToleratedVersion,
}) {
  return ForceUpdateManager(
    versionCheckService: versionCheckService,
    updateService: updateService,
    currentVersion: currentVersion,
    minToleratedVersion: minToleratedVersion,
  );
}

// Example usage function
void checkForUpdates(BuildContext context, ForceUpdateManager manager) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    manager.checkForUpdates(context);
  });
}
