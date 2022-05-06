import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../browse/views/browse_view.dart';
import '../../browse/widgets/browse_appbar_actions.dart';
import '../../downloads/views/downloads_view.dart';
import '../../library/views/library_view.dart';
import '../../library/widgets/library_appbar_actions.dart';
import '../../more/views/more_view.dart';
import '../../updates/views/updates_view.dart';
import '../controllers/home_controller.dart';
import '../widgets/big_screen_navigation_bar.dart';

// const List<String> navigationBarTitles = [
//   LocaleKeys.screenTitle_library,
//   LocaleKeys.screenTitle_updates,
//   LocaleKeys.screenTitle_browse,
//   LocaleKeys.screenTitle_downloads,
//   LocaleKeys.screenTitle_more,
// ];

// class HomeView extends GetView<HomeController> {
//   @override
//   Widget build(BuildContext context) {
//     final screen = <Widget>[
//       LibraryView(),
//       UpdatesView(),
//       BrowseView(),
//       DownloadsView(),
//       MoreView(),
//     ];

//     return Scaffold(
//       body: Obx(
//         () => screen[controller.indexscreen.value],
//       ),
//       bottomNavigationBar: ScrollToHideWidgetState(
//         scrollcontroller: controller.scrollController,
//         child: NavigationBarTheme(
//           data: NavigationBarThemeData(
//             labelTextStyle: MaterialStateProperty.all(
//               const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//           ),
//           child: Obx(
//             () => NavigationBar(
//               selectedIndex: controller.indexscreen.value,
//               onDestinationSelected: (index) =>
//                   controller.downloadCondition(index),
//               //  controller.indexscreen = index))),
//               height: 60,

//               backgroundColor: Theme.of(context).colorScheme.background,
//               labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
//               destinations: [
//                 NavigationDestination(
//                   selectedIcon: Icon(
//                     Icons.collections_bookmark_rounded,
//                   ),
//                   label: navigationBarTitles[0].tr,
//                   icon: Icon(
//                     Icons.collections_bookmark_outlined,
//                   ),
//                 ),
//                 NavigationDestination(
//                   selectedIcon: Icon(
//                     Icons.new_releases_rounded,
//                   ),
//                   label: navigationBarTitles[1].tr,
//                   icon: Icon(
//                     Icons.new_releases_outlined,
//                   ),
//                 ),
//                 NavigationDestination(
//                   selectedIcon: Icon(
//                     Icons.explore_rounded,
//                   ),
//                   label: navigationBarTitles[2].tr,
//                   icon: Icon(
//                     Icons.explore_outlined,
//                   ),
//                 ),
//                 NavigationDestination(
//                   selectedIcon: Icon(
//                     Icons.download_rounded,
//                   ),
//                   label: navigationBarTitles[3].tr,
//                   icon: Icon(
//                     Icons.download_outlined,
//                   ),
//                 ),
//                 NavigationDestination(
//                   selectedIcon: Icon(
//                     Icons.more_horiz_rounded,
//                   ),
//                   label: navigationBarTitles[4].tr,
//                   icon: Icon(
//                     Icons.more_horiz_outlined,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ScrollToHideWidgetState
    extends GetView<ScrollToHideWidgetStateController> {
  final Widget child;
  final ScrollController scrollcontroller;
  final Duration duration;
  final double height;

  const ScrollToHideWidgetState(
      {Key? key,
      required this.child,
      required this.scrollcontroller,
      this.duration = const Duration(milliseconds: 200),
      this.height = kBottomNavigationBarHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ScrollToHideWidgetStateController(
      scrollcontroller: scrollcontroller,
    ));
    return Obx(
      () => AnimatedContainer(
        duration: duration,
        height: controller.isVisible.value ? height : 0,
        child: Wrap(
          children: [child],
        ),
      ),
    );
  }
}

class ScrollToHideWidgetStateController extends GetxController {
  final ScrollController scrollcontroller;

  ScrollToHideWidgetStateController({required this.scrollcontroller});

  RxBool isVisible = true.obs;
  @override
  void onInit() {
    scrollcontroller.addListener(listen);

    super.onInit();
  }

  @override
  void dispose() {
    scrollcontroller.removeListener(listen);

    super.dispose();
  }

  // void listen() {
  //   if (scrollcontroller.position.pixels >= 68) {
  //     hide();
  //   } else {
  //     show();
  //   }
  // }

  void listen() {
    final direction = scrollcontroller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible.value) {
      isVisible.value = true;
      update();
    }
  }

  void hide() {
    if (isVisible.value) {
      isVisible.value = false;
      update();
    }
  }
}
