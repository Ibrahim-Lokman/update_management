import 'package:flutter/material.dart';
import '../models/update_info.dart';

class UpdateDialog extends StatelessWidget {
  final UpdateInfo updateInfo;
  final VoidCallback onUpdate;
  final VoidCallback? onLater;
  final bool isForceUpdate;

  const UpdateDialog({
    Key? key,
    required this.updateInfo,
    required this.onUpdate,
    this.onLater,
    required this.isForceUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isForceUpdate ? 'Update Required' : 'Update Available'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'A new version (${updateInfo.latestVersion?.toString() ?? 'Unknown'}) is available.'),
          const SizedBox(height: 8),
          updateInfo.releaseNotes == null
              ? SizedBox.shrink()
              : Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      updateInfo.releaseNotes.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
          if (isForceUpdate)
            const Text(
              '\nThis update is required to continue using the app.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
        ],
      ),
      actions: [
        if (!isForceUpdate)
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
