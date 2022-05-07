import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/reader_controller.dart';
import 'reader_page_menu.dart';

Future<dynamic> readerPageBottomSheet({
  required int index,
  required BuildContext context,
  required ReaderController controller,
  Map<String, String>? headers,
}) {
  return Get.bottomSheet(BottomSheet(
      onClosing: () {},
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (context) {
        return ReaderPageMenu(
          pageNumber: index,
          controller: controller,
          headers: headers,
        );
      }));
}
