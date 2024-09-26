import 'package:flutter/material.dart';
import '../models/update_info.dart';

abstract class UpdateStrategy {
  Future<void> execute(BuildContext context, UpdateInfo updateInfo);
}
