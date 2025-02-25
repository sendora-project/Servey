import 'package:flutter/material.dart';

class BoxComponent {
  static SizedBox zero() => const SizedBox.shrink();

  static SizedBox get smallWidth => const SizedBox(width: 10);
  static SizedBox get mediumWidth => const SizedBox(width: 15);
  static SizedBox get bigWidth => const SizedBox(width: 20);

  static SizedBox width(double width) => SizedBox(width: width);

  static SizedBox get smallHeight => const SizedBox(height: 10);
  static SizedBox get mediumHeight => const SizedBox(height: 15);
  static SizedBox get bigHeight => const SizedBox(height: 20);

  static SizedBox height(double height) => SizedBox(height: height);
}
