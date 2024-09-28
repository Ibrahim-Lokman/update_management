import 'package:http/http.dart' as http;
import 'package:update_management/feature/force_update/models/update_info.dart';
import 'dart:convert';

abstract class VersionCheckService {
  Future<UpdateInfo> checkVersion(AppVersion currentVersion);
}

class ApiVersionCheck implements VersionCheckService {
  final String apiUrl;

  ApiVersionCheck(this.apiUrl);

  @override
  Future<UpdateInfo> checkVersion(AppVersion currentVersion) async {
    final dummyData = {
      // 'latestVersion': '1.3.0',
      'minToleratedVersion': '1.1.0',
      'updateType': 'soft',
      'updateUrl':
          'https://play.google.com/store/apps/details?id=tech.innospace.brritto',
      'releaseNotes': 'Bug fixes and performance improvements.'
    };
    // final response =
    //     await http.get(Uri.parse('$apiUrl?current_version=$currentVersion'));

    final response = http.Response(json.encode(dummyData), 200);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return UpdateInfo.fromJson(data);
    } else {
      throw Exception('Failed to check for updates');
    }
  }
}
