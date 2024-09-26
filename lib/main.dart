import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:update_management/feature/force_update/force_update.dart';
import 'package:update_management/feature/force_update/force_update_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final forceUpdateManager = setupForceUpdate(
  versionCheckService: FirebaseVersionCheck(FirebaseRemoteConfig.instance),
  updateService: UpdateService(),
  currentVersion: const AppVersion(major: 1, minor: 0, patch: 0),
  minToleratedVersion: const AppVersion(major: 1, minor: 0, patch: 0),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          checkForUpdates(context, forceUpdateManager);
          return Scaffold(
              appBar: AppBar(
                title: const Text('Update Management'),
              ),
              body: const Center(child: Text('Checking for updates...')));
        },
      ),
    );
  }
}
