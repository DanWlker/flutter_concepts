// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ExtendedThemeStyle extends ThemeExtension<ExtendedThemeStyle> {
  Color surfaceColorOne;
  Color surfaceColorTwo;
  Color surfaceColorThree;
  Color floatingActionButtonColor;

  ExtendedThemeStyle({
    required this.surfaceColorOne,
    required this.surfaceColorTwo,
    required this.surfaceColorThree,
    required this.floatingActionButtonColor,
  });

  @override
  ThemeExtension<ExtendedThemeStyle> copyWith({
    Color? surfaceColorOne,
    Color? surfaceColorTwo,
    Color? surfaceColorThree,
    Color? floatingActionButtonColor,
  }) =>
      ExtendedThemeStyle(
        surfaceColorOne: surfaceColorOne ?? this.surfaceColorOne,
        surfaceColorTwo: surfaceColorTwo ?? this.surfaceColorTwo,
        surfaceColorThree: surfaceColorThree ?? this.surfaceColorThree,
        floatingActionButtonColor:
            floatingActionButtonColor ?? this.floatingActionButtonColor,
      );

  @override
  ThemeExtension<ExtendedThemeStyle> lerp(
      covariant ThemeExtension<ExtendedThemeStyle>? other, double t) {
    if (other is! ExtendedThemeStyle) {
      return this;
    }

    return ExtendedThemeStyle(
      surfaceColorOne: Color.lerp(surfaceColorOne, other.surfaceColorOne, t) ??
          surfaceColorOne,
      surfaceColorTwo: Color.lerp(surfaceColorOne, other.surfaceColorOne, t) ??
          surfaceColorTwo,
      surfaceColorThree:
          Color.lerp(surfaceColorOne, other.surfaceColorOne, t) ??
              surfaceColorThree,
      floatingActionButtonColor: Color.lerp(
              floatingActionButtonColor, other.floatingActionButtonColor, t) ??
          floatingActionButtonColor,
    );
  }
}
