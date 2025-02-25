import 'package:flutter/material.dart';

import '../utils/theme.dart';

class ContainerComponent extends StatelessWidget {
  final double? width, height;
  final EdgeInsets padding;
  final BorderRadiusGeometry? radius;
  final Border? border;
  final BoxShape shape;
  final Widget? content;
  final Color backgroundColor;

  const ContainerComponent({
    super.key,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(10),
    this.radius,
    this.border,
    this.shape = BoxShape.rectangle,
    this.content,
    this.backgroundColor = ThemeUtils.kBackground,
  });

  @override
  Widget build(BuildContext context) => _buildContainer();

  Container _buildContainer() {
    return Container(
      width: width,
      height: height,
      decoration: _buildDecoration(),
      child: Padding(padding: padding, child: content),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: backgroundColor,
      shape: shape,
      borderRadius: radius ?? BorderRadius.circular(5),
      border: border,
    );
  }
}
