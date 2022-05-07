import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

String randomName() {
  final rand = Random();
  return [
    '¯\\_(ツ)_/¯',
    '(･o･;)',
    'Σ(ಠ_ಠ)',
    'ಥ_ಥ',
    '(˘･_･˘)',
    '(；￣Д￣)',
    '(･Д･。',
  ].elementAt(rand.nextInt(7));
}

class EmoticonsView extends StatelessWidget {
  const EmoticonsView({
    Key? key,
    required this.text,
    this.button,
  }) : super(key: key);
  final String text;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          title: Text(
            randomName(),
            textAlign: TextAlign.center,
            style: Get.textTheme.headlineLarge,
          ),
          subtitle: Text(
            text,
            textAlign: TextAlign.center,
            style: Get.textTheme.headlineSmall,
          ),
        ),
        button ?? Container()
      ],
    );
  }
}
