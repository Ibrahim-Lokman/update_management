import 'package:firebase_database/firebase_database.dart';
import '../models/app_version.dart';

class FirebaseService {
  static final DatabaseReference _database = FirebaseDatabase.instance.ref();

  static Future<AppVersion?> getLatestVersion() async {
    print("getLatestVersion");
    try {
      final snapshot = await _database.child('app_versions').get();
      print(snapshot.value);
      if (snapshot.exists) {
        print("snapshot.exists");
        final data = snapshot.value as Map<dynamic, dynamic>;
        return AppVersion.fromMap(data);
      }
    } catch (e) {
      print("error $e");
    }

    return null;
  }
}
