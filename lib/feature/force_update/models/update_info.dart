import 'package:update_management/feature/force_update/models/app_version.dart';
import 'package:update_management/feature/force_update/models/update_type.dart';

class UpdateInfo {
  final AppVersion latestVersion;
  final UpdateType updateType;
  final String updateUrl;
  final String releaseNotes;

  UpdateInfo({
    required this.latestVersion,
    required this.updateType,
    required this.updateUrl,
    required this.releaseNotes,
  });

  @override
  String toString() {
    // TODO: implement toString

    return 'UpdateInfo(latestVersion: $latestVersion, updateType: $updateType, updateUrl: $updateUrl, releaseNotes: $releaseNotes)';
  }
}
