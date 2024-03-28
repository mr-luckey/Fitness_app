import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/theme/app_theme.dart';
import 'package:vipt/app/data/services/app_start_service.dart';
import 'app/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppStartService.instance.initService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
