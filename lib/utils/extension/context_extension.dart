import 'package:flutter/material.dart';

extension ContextEx on BuildContext{
  /// Theme
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Dimens
  double get sh => MediaQuery.of(this).size.height;
  double get sw => MediaQuery.of(this).size.width;
  double get safeTopHeight => MediaQuery.of(this).viewPadding.top;
}