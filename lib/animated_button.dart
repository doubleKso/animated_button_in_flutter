import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({Key? key}) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  final boderRadius = BorderRadius.circular(20);
  final imgBoderRadius = BorderRadius.circular(15);
  late final animation = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 700));
  bool _small = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final tween = _small
            ? Curves.elasticOut.transform(animation.value)
            : Curves.elasticIn.transform(animation.value);
        final elevation = lerpDouble(10, 20, tween)!;
        final padding = EdgeInsets.lerp(
            const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15.0,
            ),
            const EdgeInsets.symmetric(
              vertical: 25.0,
              horizontal: 20.0,
            ),
            tween)!;
        final color = Color.lerp(Colors.cyan, Colors.lightBlue, tween)!;
        final angle = lerpDouble(0, 2 * pi, tween)!;
        final imgWidth = lerpDouble(100, 140, tween)!;
        final imgHeight = lerpDouble(80, 100, tween)!;
        final nameTextStyle = TextStyle.lerp(
            const TextStyle(
              fontSize: 18,
              color: Colors.amber,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
            const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
            tween)!;
        final positionTextStyle = TextStyle.lerp(
            const TextStyle(
              letterSpacing: -0.5,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            const TextStyle(
              letterSpacing: 1.0,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
            tween)!;
        return Material(
          elevation: elevation,
          borderRadius: boderRadius,
          color: color,
          child: InkWell(
            onTap: () {
              setState(() {
                _small = !_small;
              });
              if (_small) {
                animation.forward(from: 0);
              } else {
                animation.reverse(from: 1);
              }
            },
            borderRadius: boderRadius,
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.rotate(
                    angle: angle,
                    child: ClipRRect(
                      borderRadius: imgBoderRadius,
                      child: Image.network(
                        'https://www.korealandscape.net//wp-content/uploads/2023/03/%EC%84%B1-%EA%B0%95-Sung-Kang.jpg',
                        width: imgWidth,
                        height: imgHeight,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kaung Khant Oo',
                        style: nameTextStyle,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '@Flutter Dev',
                        style: positionTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
