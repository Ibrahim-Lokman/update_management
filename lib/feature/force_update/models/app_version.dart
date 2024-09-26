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
    // TODO: implement toString

    return 'AppVersion(major: $major, minor: $minor, patch: $patch)';
  }

  @override
  int compareTo(AppVersion other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    return patch.compareTo(other.patch);
  }
}
