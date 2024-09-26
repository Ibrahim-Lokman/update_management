// import 'package:flutter/material.dart';
// import '../models/update_info.dart';
// import '../models/app_version.dart';
// import '../utils/version_comparator.dart';
// import 'update_strategy.dart';
// import 'forced_update_strategy.dart';
// import 'soft_update_strategy.dart';

// class MinToleranceUpdateStrategy implements UpdateStrategy {
//   final UpdateStrategy forcedStrategy;
//   final UpdateStrategy softStrategy;
//   final AppVersion minToleratedVersion;

//   MinToleranceUpdateStrategy({
//     required this.forcedStrategy,
//     required this.softStrategy,
//     required this.minToleratedVersion,
//   });

//   @override
//   Future<void> execute(BuildContext context, UpdateInfo updateInfo) async {
//     if (VersionComparator.compare(
//             updateInfo.latestVersion, minToleratedVersion) >
//         0) {
//       await forcedStrategy.execute(context, updateInfo);
//     } else {
//       await softStrategy.execute(context, updateInfo);
//     }
//   }
// }
