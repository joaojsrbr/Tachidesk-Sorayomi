import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tachidesk_sorayomi/app/modules/browse/widgets/browse_appbar_actions.dart';
import 'package:tachidesk_sorayomi/app/modules/home/controllers/home_controller.dart';
import 'package:tachidesk_sorayomi/app/modules/home/views/home_view.dart';
import 'package:tachidesk_sorayomi/app/modules/library/widgets/library_appbar_actions.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/manga_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/emoticons.dart';
import '../../../widgets/manga_grid_design.dart';
import '../controllers/library_controller.dart';

class LibraryView extends GetView<LibraryController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => NestedScrollView(
        controller: c.scrollController,
        body: Obx(
          () => controller.categoryListLength >= 1
              ? TabBarView(
                  controller: controller.tabController,
                  physics: const BouncingScrollPhysics(),
                  children: controller.categoryList.map<Widget>(
                    (e) {
                      int index = controller.categoryList.indexOf(e);
                      List<Manga>? mangaList =
                          controller.categoryMangaMap[index];
                      return mangaList != null && mangaList.isNotEmpty
                          ? GridView.builder(
                              // controller: c.scrollController,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                  right: 4, left: 4, top: 2, bottom: 2),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 205,
                                crossAxisSpacing: 2.0,
                                mainAxisSpacing: 2.0,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: mangaList.length,
                              itemBuilder: (context, index) => MangaGridDesign(
                                colorBlendMode: BlendMode.darken,
                                manga: mangaList[index],
                                onTap: () => Get.toNamed(
                                  "${Routes.manga}/${mangaList[index].id}",
                                ),
                                isLibraryScreen: true,
                              ),
                            )
                          : (controller.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : EmoticonsView(
                                  text: "${LocaleKeys.no.tr} "
                                      "${LocaleKeys.libraryScreen_manga.tr}",
                                  button: TextButton.icon(
                                    onPressed: () => controller
                                        .loadMangaListWithCategoryId(),
                                    style: TextButton.styleFrom(),
                                    icon: Icon(Icons.refresh),
                                    label: Text(
                                      LocaleKeys.libraryScreen_refresh.tr,
                                    ),
                                  ),
                                ));
                    },
                  ).toList(),
                )
              : (controller.isCategoryLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : EmoticonsView(
                      text: "${LocaleKeys.no.tr} "
                          "${LocaleKeys.libraryScreen_manga.tr}",
                      button: TextButton.icon(
                        onPressed: () => controller.refreshLibraryScreen(),
                        style: TextButton.styleFrom(),
                        icon: Icon(Icons.refresh),
                        label: Text(
                          LocaleKeys.libraryScreen_refresh.tr,
                        ),
                      ),
                    )),
        ),
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              toolbarHeight: 70,

              pinned: true,
              floating: true,
              actions: [
                Obx(() =>
                    c.selectedIndex == 0 ? LibraryAppBarActions() : SizedBox()),
                Obx(() =>
                    c.selectedIndex == 2 ? BrowseAppBarActions() : SizedBox())
              ],
              // pinned: true,
              // floating: true,
              title: Text(navigationBarTitles[0].tr),
              bottom: controller.categoryListLength <= 1
                  ? null
                  : TabBar(
                      controller: controller.tabController,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      // padding: EdgeInsets.all(8),
                      tabs: controller.categoryList
                          .map<Tab>((e) => Tab(text: e?.name ?? ""))
                          .toList(),
                    ),
            ),
          ];
        },
      ),
    );
    //  Scaffold(
    //   appBar: controller.categoryListLength <= 1
    //       ? null
    //       : TabBar(
    //           controller: controller.tabController,
    //           padding: EdgeInsets.all(8),
    //           isScrollable: true,
    //           labelColor: context.theme.indicatorColor,
    //           unselectedLabelColor: context.textTheme.bodyText1!.color,
    //           indicator: BoxDecoration(
    //             borderRadius: BorderRadius.circular(16),
    //             color: context.theme.indicatorColor.withOpacity(.3),
    //           ),
    //           tabs: controller.categoryList
    //               .map<Tab>((e) => Tab(text: e?.name ?? ""))
    //               .toList(),
    //         ),
    //   body: Obx(
    //     () => controller.categoryListLength >= 1
    //         ? TabBarView(
    //             controller: controller.tabController,
    //             // physics: NeverScrollableScrollPhysics(),
    //             children: controller.categoryList.map<Widget>(
    //               (e) {
    //                 int index = controller.categoryList.indexOf(e);
    //                 List<Manga>? mangaList =
    //                     controller.categoryMangaMap[index];
    //                 return mangaList != null && mangaList.isNotEmpty
    //                     ? GridView.builder(
    //                         controller: controller.scrollController,
    //                         gridDelegate:
    //                             SliverGridDelegateWithMaxCrossAxisExtent(
    //                           maxCrossAxisExtent: 205,
    //                           crossAxisSpacing: 2.0,
    //                           mainAxisSpacing: 2.0,
    //                           childAspectRatio: 0.7,
    //                         ),
    //                         itemCount: mangaList.length,
    //                         itemBuilder: (context, index) => MangaGridDesign(
    //                           manga: mangaList[index],
    //                           onTap: () => Get.toNamed(
    //                             "${Routes.manga}/${mangaList[index].id}",
    //                           ),
    //                           isLibraryScreen: true,
    //                         ),
    //                       )
    //                     : (controller.isLoading
    //                         ? Center(
    //                             child: CircularProgressIndicator(),
    //                           )
    //                         : EmoticonsView(
    //                             text: "${LocaleKeys.no.tr} "
    //                                 "${LocaleKeys.libraryScreen_manga.tr}",
    //                             button: TextButton.icon(
    //                               onPressed: () => controller
    //                                   .loadMangaListWithCategoryId(),
    //                               style: TextButton.styleFrom(),
    //                               icon: Icon(Icons.refresh),
    //                               label: Text(
    //                                 LocaleKeys.libraryScreen_refresh.tr,
    //                               ),
    //                             ),
    //                           ));
    //               },
    //             ).toList(),
    //           )
    //         : (controller.isCategoryLoading
    //             ? Center(
    //                 child: CircularProgressIndicator(),
    //               )
    //             : EmoticonsView(
    //                 text: "${LocaleKeys.no.tr} "
    //                     "${LocaleKeys.libraryScreen_manga.tr}",
    //                 button: TextButton.icon(
    //                   onPressed: () => controller.refreshLibraryScreen(),
    //                   style: TextButton.styleFrom(),
    //                   icon: Icon(Icons.refresh),
    //                   label: Text(
    //                     LocaleKeys.libraryScreen_refresh.tr,
    //                   ),
    //                 ),
    //               )),
    //   ),
    // ),
  }
}
