import 'package:update_management/feature/force_update/models/app_version.dart';
import 'package:update_management/feature/force_update/models/update_info.dart';

abstract class VersionCheckService {
  Future<UpdateInfo> checkVersion(AppVersion currentVersion);
}
