import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../controllers/reader_controller.dart';

class PagaNumberSlider extends StatelessWidget {
  const PagaNumberSlider({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ReaderController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 125),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 390, //heightMIN = 50, heightMAX = 450
        width: 50,
        child: Column(
          children: [
            IconButton(
              onPressed: (controller.chapter.index ?? 0) > 1
                  ? controller.prevChapter
                  : null,
              icon: Icon(
                Icons.skip_previous_rounded,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
              child: Obx(
                () => Text(
                    (controller.currentIndex.toDouble()).toInt().toString()),
              ),
            ),
            Container(
              height: 264,
              // height:
              //     (50.0 * ((controller.chapter.pageCount ?? 1).toDouble() - 1))
              //         .clamp(40, 350), //heightMIN = 50, heightMAX = 450
              child: Obx(
                () => SfSlider.vertical(
                  isInversed: true,
                  // showTicks: true,
                  // interval: 1,
                  // showLabels: true,
                  max: (controller.chapter.pageCount ?? 1).toDouble() - 1,
                  min: 0.0,
                  value: controller.currentIndex.toDouble(),
                  onChanged: (value) {
                    controller.sliderValue.value = value.toInt();
                  },
                ),
              ),
            ),
            IconButton(
              onPressed: (controller.chapter.index ?? 1) <
                      (controller.chapter.chapterCount ?? 0)
                  ? controller.nextChapter
                  : null,
              icon: Icon(Icons.skip_next_rounded),
            ),
          ],
        ),
      ),
    );
    // return Card(
    //   color: Colors.black.withOpacity(.7),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(25),
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(
    //       horizontal: 16,
    //     ),
    //     child: Obx(() => Row(
    //           children: [
    //             Text("${controller.currentIndex + 1}"),
    //             Expanded(
    //  child: Slider.adaptive
    //                 value: controller.currentIndex.toDouble(),
    //                 min: 0,
    //                 max: (controller.chapter.pageCount ?? 1).toDouble() - 1,
    //                 onChanged: (value) {
    //                   controller.sliderValue.value = value.toInt();
    //                 },
    //               ),
    //             ),
    //             Text((controller.chapter.pageCount ?? 1).toString()),
    //           ],
    //         )),
    //   ),
    // );
  }
}
