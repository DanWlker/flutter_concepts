// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_theming_concept/extended_theme_style.dart';

class ActiveThemeExtensionProvider extends ChangeNotifier {
  var currentIndex = 0;
  List<ExtendedThemeStyle> allThemeList = [
    ExtendedThemeStyle(
      surfaceColorOne: Colors.black,
      surfaceColorTwo: Colors.green,
      surfaceColorThree: Colors.yellow,
      floatingActionButtonColor: Colors.blue,
    ),
    ExtendedThemeStyle(
      surfaceColorOne: Colors.white,
      surfaceColorTwo: Colors.red,
      surfaceColorThree: Colors.purple,
      floatingActionButtonColor: Colors.pink,
    )
  ];
  late ExtendedThemeStyle _currentActiveProvider;

  ActiveThemeExtensionProvider({
    ExtendedThemeStyle? currentActiveProvider,
  }) {
    _currentActiveProvider =
        currentActiveProvider ?? allThemeList[currentIndex];
  }

  get currentActiveProvider => _currentActiveProvider;

  set currentActiveProvider(value) {
    _currentActiveProvider = value;
    notifyListeners();
  }

  void cycleActiveTheme() {
    currentIndex += 1;
    currentActiveProvider = allThemeList[currentIndex % allThemeList.length];
  }

  void generateRandomTheme() {
    allThemeList.add(
      ExtendedThemeStyle(
        surfaceColorOne:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        surfaceColorTwo:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        surfaceColorThree:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        floatingActionButtonColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
      ),
    );
  }
}
