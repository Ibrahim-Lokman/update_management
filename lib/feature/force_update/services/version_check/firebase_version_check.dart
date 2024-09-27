// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:update_management/feature/force_update/models/app_version.dart';
// import 'package:update_management/feature/force_update/models/update_info.dart';
// import 'package:update_management/feature/force_update/models/update_type.dart';
// import 'package:update_management/feature/force_update/services/version_check/version_check_service.dart';

// class FirebaseVersionCheck implements VersionCheckService {
//   final FirebaseRemoteConfig _remoteConfig;

//   FirebaseVersionCheck(this._remoteConfig);

//   @override
//   Future<UpdateInfo> checkVersion(AppVersion currentVersion) async {
//     print("checkVersion");
//     await _remoteConfig.fetchAndActivate();

//     final latestVersion =
//         AppVersion.fromString(_remoteConfig.getString('latest_version'));
//     print("latestVersion $latestVersion ");
//     final updateType = UpdateType.values.firstWhere(
//       (e) =>
//           e.toString() ==
//           'UpdateType.${_remoteConfig.getString('update_type')}',
//       orElse: () => UpdateType.none,
//     );

//     return UpdateInfo(
//       latestVersion: latestVersion,
//       updateType: updateType,
//       updateUrl: _remoteConfig.getString('update_url'),
//       releaseNotes: _remoteConfig.getString('release_notes'),
//     );
//   }
// }
