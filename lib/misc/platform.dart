import 'package:flutter/material.dart';

class Platform {
  static bool isMobile(final BuildContext context) =>
      MediaQuery.of(context).size.shortestSide < 600;
}
