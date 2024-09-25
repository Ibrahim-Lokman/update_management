class AppVersion {
  final String version;
  final bool forceUpdate;

  AppVersion({
    required this.version,
    required this.forceUpdate,
  });

  factory AppVersion.fromMap(Map<dynamic, dynamic> map) {
    return AppVersion(
      version: map['latest_version'] as String,
      forceUpdate: map['force_update'] as bool,
    );
  }
}
