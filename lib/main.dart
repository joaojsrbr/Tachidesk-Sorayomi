import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/services/local_storage_service.dart';
import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  final controller = Get.put(LocalStorageService());
  runApp(
    GetMaterialApp(
      title: "Tachidesk Sorayomi",
      translationsKeys: AppTranslation.translations,
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(31, 10, 89, 225),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(31, 125, 5, 211),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: controller.theme,
      debugShowCheckedModeBanner: false,
    ),
  );
}
