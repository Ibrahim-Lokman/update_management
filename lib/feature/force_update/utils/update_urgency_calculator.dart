import '../models/app_version.dart';
import '../models/update_type.dart';

class UpdateUrgencyCalculator {
  static UpdateType calculateUrgency(
      AppVersion currentVersion, AppVersion latestVersion) {
    final majorDiff = latestVersion.major - currentVersion.major;
    final minorDiff = latestVersion.minor - currentVersion.minor;
    final patchDiff = latestVersion.patch - currentVersion.patch;

    if (majorDiff > 0) {
      return UpdateType.force;
    } else if (minorDiff > 0) {
      return UpdateType.soft;
    } else if (patchDiff > 0) {
      return UpdateType.none;
    } else {
      return UpdateType.none;
    }
  }
}
