import 'package:flutter/material.dart';
import 'package:flutter_theming_concept/extended_theme_style.dart';

extension ThemeContextExtension on BuildContext {
  ExtendedThemeStyle? extendedThemeStyle() {
    return Theme.of(this).extension<ExtendedThemeStyle>();
  }
}
