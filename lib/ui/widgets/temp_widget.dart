import 'package:flutter/material.dart';
import 'package:weather_app/utils/common_functions.dart';
class TempWidget extends StatelessWidget {
  const TempWidget({
    super.key,
    required this.temp,
    this.tempSize = 30,
    this.tempTextStyle,
    this.supTextStyle,
    this.supRight,
  });
  final num temp;
  final double tempSize;

  final TextStyle? tempTextStyle;
  final TextStyle? supTextStyle;
  final double? supRight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Text(
          removeZeroDouble(temp),
          style: tempTextStyle ?? TextStyle(
            fontSize: tempSize,
            color: Colors.white,
            fontWeight: FontWeight.w300,
            height: 1.1,
          ),
        ),
        Positioned(
          top: tempSize*.01,
          right: supRight ?? -(tempSize*.5),
          child: Text(
            '\u2103',
            style: supTextStyle ?? TextStyle(
              fontSize: tempSize * .5,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
