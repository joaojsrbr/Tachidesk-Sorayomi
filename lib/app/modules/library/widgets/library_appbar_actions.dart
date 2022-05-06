import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/library_controller.dart';
import 'library_filter_list_view.dart';
import 'library_sort_list_view.dart';

class LibraryAppBarActions extends StatelessWidget {
  LibraryAppBarActions({Key? key}) : super(key: key);
  final LibraryController controller = Get.find<LibraryController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            controller.isSearching
                ? Container(
                    padding: EdgeInsets.only(top: 6.0, bottom: 6.0, right: 0),
                    width: min(context.width * .5, 800),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: TextField(
                        controller: controller.textEditingController,
                        autofocus: true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            padding: const EdgeInsets.only(right: 0),
                            alignment: Alignment.centerRight,
                            icon: Icon(
                              Icons.close,
                            ),
                            onPressed: () {
                              controller.isSearching = false;
                              controller.textEditingController.clear();
                            },
                          ),
                          border: UnderlineInputBorder(),
                          // hintText: LocaleKeys.libraryScreen_mangaSearch.tr,
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () => controller.isSearching = true,
                    icon: Icon(Icons.search_rounded),
                  ),
            IconButton(
              onPressed: () {
                Get.bottomSheet(
                  BottomSheet(
                    onClosing: () {},
                    builder: (context) => DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        appBar: context.width > 700
                            ? null
                            : TabBar(
                                padding: EdgeInsets.all(8),
                                isScrollable: false,
                                labelColor: context.theme.indicatorColor,
                                unselectedLabelColor:
                                    context.textTheme.bodyText1!.color,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: context.theme.indicatorColor
                                      .withOpacity(.3),
                                ),
                                tabs: [
                                    Tab(
                                        text:
                                            LocaleKeys.libraryScreen_filter.tr),
                                    Tab(text: LocaleKeys.libraryScreen_sort.tr),
                                  ]),
                        body: context.width > 700
                            ? Row(
                                children: [
                                  Expanded(
                                    child: LibraryFilterListView(
                                      controller: controller,
                                    ),
                                  ),
                                  VerticalDivider(),
                                  Expanded(
                                    child: LibrarySortListView(
                                      controller: controller,
                                    ),
                                  ),
                                ],
                              )
                            : TabBarView(
                                children: [
                                  LibraryFilterListView(
                                    controller: controller,
                                  ),
                                  LibrarySortListView(
                                    controller: controller,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.filter_list_rounded),
            ),
          ],
        ));
  }
}

class MyseachDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
