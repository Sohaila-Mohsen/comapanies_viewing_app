import 'package:authentication_app/src/app_root.dart';
import 'package:authentication_app/utils/sp_helper/cache_helper.dart';
import 'package:flutter/material.dart';

import 'services/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await SharedPreferencesHelper.init();
  DioHelper.init();
  runApp(AppRoot());
}
