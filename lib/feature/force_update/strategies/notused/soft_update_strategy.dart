// import 'package:flutter/material.dart';
// import '../models/update_info.dart';
// import '../ui/update_dialog.dart';
// import '../services/update_service.dart';
// import 'update_strategy.dart';

// class SoftUpdateStrategy implements UpdateStrategy {
//   final UpdateService updateService;

//   SoftUpdateStrategy(this.updateService);

//   @override
//   Future<void> execute(BuildContext context, UpdateInfo updateInfo) async {
//     showDialog(
//       context: context,
//       builder: (context) => UpdateDialog(
//         updateInfo: updateInfo,
//         onUpdate: () => updateService.performUpdate(updateInfo.updateUrl),
//         onLater: () => Navigator.of(context).pop(),
//       ),
//     );
//   }
// }
