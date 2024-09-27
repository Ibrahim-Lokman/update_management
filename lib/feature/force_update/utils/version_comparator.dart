import '../models/app_version.dart';

class VersionComparator {
  static int compare(AppVersion v1, AppVersion v2) {
    return v1.compareTo(v2);
  }

  static bool isUpdateRequired(
      AppVersion currentVersion, AppVersion latestVersion) {
    return compare(currentVersion, latestVersion) < 0;
  }

  static bool isVersionBelowMinTolerance(
      AppVersion currentVersion, AppVersion minToleranceVersion) {
    return compare(currentVersion, minToleranceVersion) < 0;
  }
}
