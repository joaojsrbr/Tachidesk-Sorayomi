import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/reader_controller.dart';
import 'reader_settings_menu.dart';

Future<dynamic> readerSettingsBottomSheet({
  required BuildContext context,
  required ReaderController controller,
  Map<String, String>? headers,
}) {
  return Get.bottomSheet(
    BottomSheet(
      backgroundColor: Theme.of(context).colorScheme.background,
      onClosing: () {},
      builder: (context) {
        return ReaderSettingsMenu(controller: controller);
      },
    ),
  );
}
