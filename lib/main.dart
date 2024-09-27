import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:update_management/feature/force_update/force_update_manager.dart';
import 'package:update_management/feature/force_update/services/version_check/api_version_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get current version from pubspec.yaml
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = AppVersion.fromString(packageInfo.version);

  final apiVersionCheck =
      ApiVersionCheck('https://your-api-endpoint.com/version');

  final forceUpdateManager = setupForceUpdate(
    versionCheckService: apiVersionCheck,
    updateService: UpdateService(),
    currentVersion: currentVersion,
  );

  runApp(MyApp(forceUpdateManager: forceUpdateManager));
}

class MyApp extends StatelessWidget {
  final ForceUpdateManager forceUpdateManager;

  const MyApp({Key? key, required this.forceUpdateManager}) : super(key: key);

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
