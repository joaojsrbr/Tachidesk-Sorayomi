import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tachidesk_sorayomi/app/modules/browse/controllers/browse_controller.dart';
import 'package:tachidesk_sorayomi/app/modules/updates/controllers/updates_controller.dart';

import '../../library/controllers/library_controller.dart';
import '../controllers/home_controller.dart';

class SmallScreenNavigationBar extends StatelessWidget {
  const SmallScreenNavigationBar({
    Key? key,
    required this.controller,
    required this.navigationBarTitles,
  }) : super(key: key);

  final HomeController controller;
  final List<String> navigationBarTitles;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => ScrollToHideWidgetState(
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          child: Obx(
            () => NavigationBar(
              height: 60,
              backgroundColor: Theme.of(context).colorScheme.background,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: controller.selectedIndex,
              onDestinationSelected: (value) =>
                  controller.selectedIndex = value,
              destinations: <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.collections_bookmark_rounded,
                  ),
                  label: navigationBarTitles[0].tr,
                  icon: Icon(
                    Icons.collections_bookmark_outlined,
                  ),
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.new_releases_rounded,
                  ),
                  label: navigationBarTitles[1].tr,
                  icon: Icon(
                    Icons.new_releases_outlined,
                  ),
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.explore_rounded,
                  ),
                  label: navigationBarTitles[2].tr,
                  icon: Icon(
                    Icons.explore_outlined,
                  ),
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.download_rounded,
                  ),
                  label: navigationBarTitles[3].tr,
                  icon: Icon(
                    Icons.download_outlined,
                  ),
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.more_horiz_rounded,
                  ),
                  label: navigationBarTitles[4].tr,
                  icon: Icon(
                    Icons.more_horiz_outlined,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // return Obx(() => BottomNavigationBar(
    //       showUnselectedLabels: true,
    //       type: BottomNavigationBarType.fixed,
    //       unselectedItemColor: Get.theme.unselectedWidgetColor,
    //       selectedItemColor: Get.theme.indicatorColor,
    //       currentIndex: controller.selectedIndex,
    //       onTap: (value) => controller.selectedIndex = value,
    //       items: [
    //         BottomNavigationBarItem(
    //           icon: Icon(
    //             Icons.collections_bookmark_outlined,
    //           ),
    //           label: navigationBarTitles[0].tr,
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(
    //             Icons.new_releases_outlined,
    //           ),
    //           label: navigationBarTitles[1].tr,
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.explore_outlined),
    //           label: navigationBarTitles[2].tr,
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(
    //             Icons.download_outlined,
    //           ),
    //           label: navigationBarTitles[3].tr,
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(
    //             Icons.more_horiz_outlined,
    //           ),
    //           label: navigationBarTitles[4].tr,
    //         ),
    //       ],
    //     ));
  }
}

class ScrollToHideWidgetState
    extends GetView<ScrollToHideWidgetStateController> {
  final Widget child;

  final Duration duration;
  final double height;

  const ScrollToHideWidgetState(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 200),
      this.height = kBottomNavigationBarHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  final libraryControllerscroll = Get.find<LibraryController>();
  final updatesControllerscroll = Get.find<UpdatesController>();
  final browseControllerscroll = Get.find<BrowseController>();

  RxBool isVisible = true.obs;
  @override
  void onInit() {
    browseControllerscroll.scrollController.addListener(listen);
    libraryControllerscroll.scrollController.addListener(listen2);
    updatesControllerscroll.scrollController.addListener(listen3);
    super.onInit();
  }

  @override
  void dispose() {
    browseControllerscroll.scrollController.removeListener(listen);
    libraryControllerscroll.scrollController.removeListener(listen2);
    updatesControllerscroll.scrollController.removeListener(listen3);

    super.dispose();
  }

  void listen() {
    if (browseControllerscroll.scrollController.position.pixels >= 68) {
      hide();
    } else {
      show();
    }
  }

  void listen2() {
    if (libraryControllerscroll.scrollController.position.pixels >= 68) {
      hide();
    } else {
      show();
    }
  }

  void listen3() {
    if (updatesControllerscroll.scrollController.position.pixels >= 68) {
      hide();
    } else {
      show();
    }
  }

  // void listen() {
  //   final direction = scrollcontroller.position.userScrollDirection;
  //   if (direction == ScrollDirection.forward) {
  //     show();
  //   } else if (direction == ScrollDirection.reverse) {
  //     hide();
  //   }
  // }

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
