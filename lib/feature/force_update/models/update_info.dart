class UpdateInfo {
  final AppVersion latestVersion;
  final AppVersion minToleratedVersion;
  final UpdateType updateType;
  final String updateUrl;
  final String releaseNotes;

  UpdateInfo({
    required this.latestVersion,
    required this.minToleratedVersion,
    required this.updateType,
    required this.updateUrl,
    required this.releaseNotes,
  });

  UpdateInfo copyWith({
    AppVersion? latestVersion,
    AppVersion? minToleratedVersion,
    UpdateType? updateType,
    String? updateUrl,
    String? releaseNotes,
  }) {
    return UpdateInfo(
      latestVersion: latestVersion ?? this.latestVersion,
      minToleratedVersion: minToleratedVersion ?? this.minToleratedVersion,
      updateType: updateType ?? this.updateType,
      updateUrl: updateUrl ?? this.updateUrl,
      releaseNotes: releaseNotes ?? this.releaseNotes,
    );
  }

  @override
  String toString() {
    return 'UpdateInfo(latestVersion: $latestVersion, minToleratedVersion: $minToleratedVersion, updateType: $updateType, updateUrl: $updateUrl, releaseNotes: $releaseNotes)';
  }
}

enum UpdateType {
  force,
  soft,
  none,
}

class AppVersion implements Comparable<AppVersion> {
  final int major;
  final int minor;
  final int patch;

  const AppVersion(
      {required this.major, required this.minor, required this.patch});

  factory AppVersion.fromString(String version) {
    final parts = version.split('.');
    return AppVersion(
      major: int.parse(parts[0]),
      minor: int.parse(parts[1]),
      patch: int.parse(parts[2]),
    );
  }

  @override
  String toString() {
    return 'AppVersion(major: $major, minor: $minor, patch: $patch)';
  }

  @override
  int compareTo(AppVersion other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    return patch.compareTo(other.patch);
  }
}
