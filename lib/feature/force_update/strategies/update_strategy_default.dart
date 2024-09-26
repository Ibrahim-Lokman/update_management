import 'package:flutter/material.dart';
import 'package:update_management/feature/force_update/models/update_type.dart';
import '../models/update_info.dart';
import '../ui/update_dialog.dart';
import '../services/update_service.dart';
import 'update_strategy.dart';

class UpdateStrategyImpl implements UpdateStrategy {
  final UpdateService updateService;

  UpdateStrategyImpl(this.updateService);

  @override
  Future<void> execute(BuildContext context, UpdateInfo updateInfo) async {
    showDialog(
      barrierDismissible: updateInfo.updateType != UpdateType.force,
      context: context,
      builder: (context) => UpdateDialog(
        updateInfo: updateInfo,
        onUpdate: () => updateService.performUpdate(updateInfo.updateUrl),
        onLater: () => Navigator.of(context).pop(),
      ),
    );
  }
}
