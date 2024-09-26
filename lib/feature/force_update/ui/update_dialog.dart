import 'package:flutter/material.dart';
import '../models/update_info.dart';
import '../models/update_type.dart';

class UpdateDialog extends StatelessWidget {
  final UpdateInfo updateInfo;
  final VoidCallback onUpdate;
  final VoidCallback? onLater;

  const UpdateDialog({
    Key? key,
    required this.updateInfo,
    required this.onUpdate,
    this.onLater,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(updateInfo.updateType == UpdateType.force
          ? 'Update Required'
          : 'Update Available'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'A new version (${updateInfo.latestVersion} ${updateInfo.updateType} is available.'),
          const SizedBox(height: 8),
          Text(updateInfo.releaseNotes),
        ],
      ),
      actions: [
        if (updateInfo.updateType != UpdateType.force)
          TextButton(
            onPressed: onLater,
            child: const Text('Later'),
          ),
        ElevatedButton(
          onPressed: onUpdate,
          child: const Text('Update Now'),
        ),
      ],
    );
  }
}
