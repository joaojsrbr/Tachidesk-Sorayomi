import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tachidesk_sorayomi/app/modules/browse/widgets/browse_appbar_actions.dart';
import 'package:tachidesk_sorayomi/app/modules/home/controllers/home_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../extensions/views/extensions_view.dart';
import '../../home/views/home_view.dart';
import '../../sources/views/sources_view.dart';
import '../controllers/browse_controller.dart';

class BrowseView extends GetView<BrowseController> {
  @override
  Widget build(BuildContext context) {
    final _ = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            toolbarHeight: 70,
            pinned: true,
            floating: true,
            snap: true,
            // stretch: true,
            actions: [
              Obx(() =>
                  _.selectedIndex == 2 ? BrowseAppBarActions() : SizedBox())
            ],
            title: Text(navigationBarTitles[2].tr),
            bottom: TabBar(
              physics: BouncingScrollPhysics(),
              controller: controller.tabController,
              isScrollable: context.width > 700 ? true : false,
              labelColor: context.theme.indicatorColor,
              unselectedLabelColor: context.textTheme.bodyText1!.color,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: [
                Tab(text: LocaleKeys.screenTitle_sources.tr),
                Tab(text: LocaleKeys.screenTitle_extensions.tr),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: controller.tabController,
          physics: BouncingScrollPhysics(),
          children: [
            SourcesView(),
            ExtensionsView(),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Theme.of(context).colorScheme.background,
    //   appBar: TabBar(
    //       physics: BouncingScrollPhysics(),
    //       controller: controller.tabController,
    //       padding: EdgeInsets.all(8),
    //       isScrollable: context.width > 700 ? true : false,
    //       labelColor: context.theme.indicatorColor,
    //       unselectedLabelColor: context.textTheme.bodyText1!.color,
    //       indicator: BoxDecoration(
    //         borderRadius: BorderRadius.circular(16),
    //         color: context.theme.indicatorColor.withOpacity(.3),
    //       ),
    //       tabs: [
    //         Tab(text: LocaleKeys.screenTitle_sources.tr),
    //         Tab(text: LocaleKeys.screenTitle_extensions.tr),
    //       ]),
    //   body: TabBarView(
    //     controller: controller.tabController,
    //     physics: BouncingScrollPhysics(),
    //     children: [
    //       SourcesView(),
    //       ExtensionsView(),
    //     ],
    //   ),
    // );
  }
}
