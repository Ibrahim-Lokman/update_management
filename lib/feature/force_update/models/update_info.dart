class UpdateInfo {
  final AppVersion? latestVersion;
  final AppVersion? minToleratedVersion;
  final UpdateType? updateType;
  final String? updateUrl;
  final String? releaseNotes;

  UpdateInfo({
    this.latestVersion,
    this.minToleratedVersion,
    this.updateType,
    this.updateUrl,
    this.releaseNotes,
  });

  factory UpdateInfo.fromJson(Map<String, dynamic> json) {
    return UpdateInfo(
      latestVersion: json['latestVersion'] != null
          ? AppVersion.fromString(json['latestVersion'])
          : null,
      minToleratedVersion: json['minToleratedVersion'] != null
          ? AppVersion.fromString(json['minToleratedVersion'])
          : null,
      // updateType: json['updateType'] != null
      //     ? UpdateType.values.firstWhere(
      //         (e) => e.toString() == 'UpdateType.${json['updateType']}',
      //         orElse: () => UpdateType.none,
      //       )
      //     : null,
      updateType: _parseUpdateType(json['updateType']),
      updateUrl: json['updateUrl'],
      releaseNotes: json['releaseNotes'],
    );
  }
  static UpdateType? _parseUpdateType(String? updateType) {
    if (updateType == null) return null;
    if (updateType.toLowerCase().contains('force') ||
        updateType.toLowerCase().contains('hard')) {
      return UpdateType.force;
    } else if (updateType.toLowerCase().contains('soft')) {
      return UpdateType.soft;
    } else if (updateType.toLowerCase().contains('none')) {
      return UpdateType.none;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'latestVersion': latestVersion?.toString(),
      'minToleratedVersion': minToleratedVersion?.toString(),
      'updateType': updateType?.toString().split('.').last,
      'updateUrl': updateUrl,
      'releaseNotes': releaseNotes,
    };
  }

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

// AppVersion class remains unchanged
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
    return '$major.$minor.$patch';
  }

  @override
  int compareTo(AppVersion other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    return patch.compareTo(other.patch);
  }
}
