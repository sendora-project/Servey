import 'package:flutter/material.dart';

import '../misc/platform.dart';
import '../utils/theme.dart';
import 'box.dart';

class ButtonComponent extends StatefulWidget {
  final double? width, height;
  final EdgeInsets padding;
  final BorderRadiusGeometry? radius;
  final Border? border;
  final BoxShape shape;
  final Widget? content;
  final void Function() onPressed;
  final bool interactable;
  final Color? backgroundColor, hoverColor;

  const ButtonComponent({
    super.key,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(5),
    this.radius = const BorderRadius.all(Radius.circular(8)),
    this.border,
    this.shape = BoxShape.rectangle,
    this.content,
    required this.onPressed,
    this.interactable = true,
    this.backgroundColor = ThemeUtils.kDark,
    this.hoverColor = const Color(0xffe0e0e0),
  });

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Platform.isMobile(context) ? _buildButton() : _buildDesktopButton();
  }

  MouseRegion _buildDesktopButton() {
    return MouseRegion(
      cursor:
          widget.interactable
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
      onEnter: (e) => setState(() => isHovered = true),
      onExit: (e) => setState(() => isHovered = false),
      child: _buildButton(),
    );
  }

  GestureDetector _buildButton() {
    return GestureDetector(
      onTap: widget.interactable ? widget.onPressed : null,
      child: _buildContent(),
    );
  }

  Container _buildContent() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: _buildBoxDecoration(),
      child: Padding(
        padding: widget.padding,
        child: Center(child: widget.content),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: isHovered ? widget.hoverColor : widget.backgroundColor,
      shape: widget.shape,
      borderRadius: widget.radius ?? BorderRadius.circular(5),
      border: widget.border,
    );
  }
}

class IconButtonComponent extends StatefulWidget {
  final double? width, height;
  final bool clickable;
  final String? tip;
  final Icon icon;
  final Text? text;
  final void Function() onPressed;

  const IconButtonComponent({
    super.key,
    this.width,
    this.height,
    this.clickable = true,
    this.tip,
    required this.icon,
    required this.onPressed,
    this.text,
  });

  @override
  State<IconButtonComponent> createState() => _IconButtonComponentState();
}

class _IconButtonComponentState extends State<IconButtonComponent> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Platform.isMobile(context);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: isMobile ? _buildButton() : _buildDesktopButton(),
    );
  }

  Widget _buildDesktopButton() {
    return Tooltip(
      waitDuration: const Duration(milliseconds: 600),
      message: widget.tip ?? '',
      child: MouseRegion(
        cursor:
            widget.clickable
                ? SystemMouseCursors.click
                : SystemMouseCursors.forbidden,
        onEnter: (e) => setState(() => isHovered = true),
        onExit: (e) => setState(() => isHovered = false),
        child: _buildButton(),
      ),
    );
  }

  _buildButton() {
    return GestureDetector(
      onTap: widget.clickable ? widget.onPressed : () {},
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    bool isMobile = Platform.isMobile(context);

    final icon =
        isMobile
            ? widget.icon
            : Icon(
              widget.icon.icon,
              color: isHovered ? ThemeUtils.kPrimary : widget.icon.color,
            );

    final text =
        isMobile
            ? widget.text
            : widget.text != null
            ? Text(
              widget.text!.data!,
              style:
                  isHovered
                      ? widget.text!.style!.copyWith(color: ThemeUtils.kPrimary)
                      : widget.text!.style,
            )
            : null;

    final content =
        text == null
            ? icon
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [icon, BoxComponent.height(5), text],
            );

    return content;
  }
}

class TextButtonComponent extends StatefulWidget {
  final Text text;
  final void Function() onPressed;
  final bool clickable;
  final Text hoverText;

  const TextButtonComponent({
    super.key,
    required this.text,
    required this.hoverText,
    required this.onPressed,
    this.clickable = true,
  });

  @override
  State<TextButtonComponent> createState() => _TextButtonComponentState();
}

class _TextButtonComponentState extends State<TextButtonComponent> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.clickable ? widget.onPressed : null,
      child: _buildMouseRegion(),
    );
  }

  MouseRegion _buildMouseRegion() {
    return MouseRegion(
      cursor:
          widget.clickable
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
      onEnter: (e) => setState(() => isHovered = true),
      onExit: (e) => setState(() => isHovered = false),
      child: isHovered ? widget.hoverText : widget.text,
    );
  }
}

class ChipButtonComponent extends StatefulWidget {
  final Widget content;

  final OutlinedBorder? shape;
  final Color? color;

  final void Function() onPressed;

  const ChipButtonComponent({
    super.key,
    required this.content,
    required this.onPressed,
    this.shape,
    this.color,
  });

  @override
  State<ChipButtonComponent> createState() => _ChipButtonComponentState();
}

class _ChipButtonComponentState extends State<ChipButtonComponent> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: widget.content,
      onPressed: () {
        setState(() => isPressed = !isPressed);
        widget.onPressed.call();
      },
      shape: widget.shape,
      backgroundColor: widget.color,
    );
  }
}
