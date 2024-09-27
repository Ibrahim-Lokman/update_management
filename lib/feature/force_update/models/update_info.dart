// import 'package:update_management/feature/force_update/models/app_version.dart';
// import 'package:update_management/feature/force_update/models/update_type.dart';

// class UpdateInfo {
//   final AppVersion latestVersion;
//   final UpdateType updateType;
//   final String updateUrl;
//   final String releaseNotes;

//   UpdateInfo({
//     required this.latestVersion,
//     required this.updateType,
//     required this.updateUrl,
//     required this.releaseNotes,
//   });

//   @override
//   String toString() {
//     // TODO: implement toString

//     return 'UpdateInfo(latestVersion: $latestVersion, updateType: $updateType, updateUrl: $updateUrl, releaseNotes: $releaseNotes)';
//   }
// }

import 'package:update_management/feature/force_update/models/app_version.dart';
import 'package:update_management/feature/force_update/models/update_type.dart';

class UpdateInfo {
  final AppVersion latestVersion;
  final AppVersion minToleratedVersion;
  final UpdateType updateType;
  final String updateUrl;
  final String releaseNotes;

  UpdateInfo({
    required this.latestVersion,
    required this.minToleratedVersion,
    required this.updateType,
    required this.updateUrl,
    required this.releaseNotes,
  });

  UpdateInfo copyWith({
    AppVersion? latestVersion,
    AppVersion? minToleratedVersion,
    UpdateType? updateType,
    String? updateUrl,
    String? releaseNotes,
  }) {
    return UpdateInfo(
      latestVersion: latestVersion ?? this.latestVersion,
      minToleratedVersion: minToleratedVersion ?? this.minToleratedVersion,
      updateType: updateType ?? this.updateType,
      updateUrl: updateUrl ?? this.updateUrl,
      releaseNotes: releaseNotes ?? this.releaseNotes,
    );
  }

  @override
  String toString() {
    return 'UpdateInfo(latestVersion: $latestVersion, minToleratedVersion: $minToleratedVersion, updateType: $updateType, updateUrl: $updateUrl, releaseNotes: $releaseNotes)';
  }
}
