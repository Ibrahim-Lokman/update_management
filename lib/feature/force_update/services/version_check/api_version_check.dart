import 'package:http/http.dart' as http;
import 'package:update_management/feature/force_update/models/app_version.dart';
import 'package:update_management/feature/force_update/models/update_info.dart';
import 'package:update_management/feature/force_update/models/update_type.dart';
import 'dart:convert';

import 'package:update_management/feature/force_update/services/version_check/version_check_service.dart';

class ApiVersionCheck implements VersionCheckService {
  final String apiUrl;

  ApiVersionCheck(this.apiUrl);

  @override
  Future<UpdateInfo> checkVersion(AppVersion currentVersion) async {
    final dummyData = {
      'latest_version': '1.1.0',
      'min_tolerated_version': '1.0.0',
      'update_type': 'force',
      'update_url': 'https://example.com/update',
      'release_notes': 'Bug fixes and performance improvements.'
    };
    // final response =
    //     await http.get(Uri.parse('$apiUrl?current_version=$currentVersion'));

    final response = http.Response(json.encode(dummyData), 200);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UpdateInfo(
        latestVersion: AppVersion.fromString(data['latest_version']),
        minToleratedVersion:
            AppVersion.fromString(data['min_tolerated_version']),
        updateType: UpdateType.values.firstWhere(
          (e) => e.toString() == 'UpdateType.${data['update_type']}',
          orElse: () => UpdateType.none,
        ),
        updateUrl: data['update_url'],
        releaseNotes: data['release_notes'],
      );
    } else {
      throw Exception('Failed to check for updates');
    }
  }
}
