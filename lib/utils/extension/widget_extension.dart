import 'dart:ui';

import 'package:flutter/material.dart';

extension TextEx on Text {
  Wrap withSuperscript(String text, TextStyle tStyle) => Wrap(
    children: [
      Text(
        data ?? '',
        style: style,
      ),
      Text(
        text,
        style: tStyle.copyWith(fontFeatures: [const FontFeature.superscripts()]),
      ),
    ]
  );
}

extension WidgetDimenExtension on num{
  SizedBox get vBox => SizedBox(height: toDouble());
  SizedBox get hBox => SizedBox(width: toDouble());
}

extension WidgetEx on Widget{
  Widget unFocusOutsideClick(BuildContext ctx) => GestureDetector(
    onTap: () => FocusScope.of(ctx).requestFocus(FocusNode()),
    child: this,
  );
}