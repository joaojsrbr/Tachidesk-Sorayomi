import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/chapter_model.dart';
import '../controllers/manga_controller.dart';
import '../widgets/chapter_card.dart';
import '../widgets/manga_description.dart';

class MangaView extends GetView<MangaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(
              controller.manga.value.title ?? LocaleKeys.mangaScreen_manga.tr,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: Icon(Icons.play_arrow_rounded),
          label: Text("Resume"),
          isExtended: context.width > 600 ? true : false,
        ),
        body: Obx(
          () => controller.isPageLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                  color: context.theme.colorScheme.secondary,
                ))
              : context.width > 600
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Obx(
                            () => SingleChildScrollView(
                              controller: ScrollController(),
                              child: MangaDescription(
                                manga: controller.manga.value,
                                addMangaToLibrary: controller.addMangaToLibrary,
                                removeMangaFromLibrary:
                                    controller.removeMangaFromLibrary,
                              ),
                            ),
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          child: Obx(
                            () => controller.isLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color:
                                          context.theme.colorScheme.secondary,
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        controller.chapterList.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        int length =
                                            controller.chapterList.length;
                                        return ListTile(
                                          title: Text(
                                            (length.isEqual(0) ? 0 : length - 1)
                                                    .toString() +
                                                " " +
                                                LocaleKeys
                                                    .mangaScreen_chapters.tr,
                                          ),
                                        );
                                      }
                                      Chapter? chapter =
                                          controller.chapterList[index - 1];
                                      return ChapterCard(
                                        chapter: chapter,
                                        controller: controller,
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ],
                    )
                  : Obx(
                      () => controller.isLoading.value
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(
                                  () => MangaDescription(
                                    manga: controller.manga.value,
                                    addMangaToLibrary:
                                        controller.addMangaToLibrary,
                                    removeMangaFromLibrary:
                                        controller.removeMangaFromLibrary,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color:
                                          context.theme.colorScheme.secondary,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: controller.chapterList.length + 2,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Obx(
                                    () => MangaDescription(
                                      manga: controller.manga.value,
                                      addMangaToLibrary:
                                          controller.addMangaToLibrary,
                                      removeMangaFromLibrary:
                                          controller.removeMangaFromLibrary,
                                    ),
                                  );
                                }
                                if (index == 1) {
                                  int length = controller.chapterList.length;
                                  return ListTile(
                                    title: Text(
                                      (length.isEqual(0) ? 0 : length - 1)
                                              .toString() +
                                          " " +
                                          LocaleKeys.mangaScreen_chapters.tr,
                                    ),
                                  );
                                }
                                Chapter? chapter =
                                    controller.chapterList[index - 2];
                                return ChapterCard(
                                  chapter: chapter,
                                  controller: controller,
                                );
                              },
                            ),
                    ),
        ));
  }
}