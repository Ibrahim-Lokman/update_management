import 'package:flutter/material.dart';
import '../models/update_info.dart';

class ForceUpdateScreen extends StatelessWidget {
  final UpdateInfo updateInfo;
  final VoidCallback onUpdate;

  const ForceUpdateScreen({
    Key? key,
    required this.updateInfo,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Required'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'A new version (${updateInfo.latestVersion?.toString() ?? 'Unknown'}) is available.',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            updateInfo.releaseNotes == null
                ? SizedBox.shrink()
                : Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        updateInfo.releaseNotes.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
            const SizedBox(height: 24),
            const Text(
              'This update is required to continue using the app.',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: onUpdate,
              child: const Text('Update Now'),
            ),
          ],
        ),
      ),
    );
  }
}
