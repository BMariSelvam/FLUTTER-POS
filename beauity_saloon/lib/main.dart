import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'helper/appRoute.dart';
import 'helper/colors.dart';
import 'helper/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: MyColors.primaryCustom),
      initialRoute: AppRoutes.splash,
      getPages: pages,
    );
  }
}

