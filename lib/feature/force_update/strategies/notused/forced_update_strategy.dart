// import 'package:flutter/material.dart';
// import '../models/update_info.dart';
// import '../ui/update_screen.dart';
// import '../services/update_service.dart';
// import 'update_strategy.dart';

// class ForcedUpdateStrategy implements UpdateStrategy {
//   final UpdateService updateService;

//   ForcedUpdateStrategy(this.updateService);

//   @override
//   Future<void> execute(BuildContext context, UpdateInfo updateInfo) async {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => UpdateScreen(
//           updateInfo: updateInfo,
//           onUpdate: () => updateService.performUpdate(updateInfo.updateUrl),
//         ),
//       ),
//     );
//   }
// }
