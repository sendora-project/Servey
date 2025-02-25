import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../misc/validations.dart';
import '../utils/style.dart';
import '../utils/theme.dart';
import 'box.dart';
import 'button.dart';

class TrailingItem {
  final Icon icon;
  final void Function()? onPressed;

  TrailingItem({required this.icon, this.onPressed});
}

class FieldComponent extends StatefulWidget {
  final double width, height;
  final bool isRequired, isSecure, bypass;
  final String? hintText;
  final String errorMessage;
  final Widget? leading;
  final TrailingItem? trailing;
  final BorderRadius? radius;
  final Border? border;
  final ValidationType validation;
  final Color backgroundColor;
  final TextEditingController controller;
  final Widget? headline;
  final int? maxLength;
  final TextInputType? inputType;

  const FieldComponent({
    super.key,
    required this.validation,
    required this.controller,
    this.width = 430,
    this.height = 50,
    this.isRequired = true,
    this.isSecure = false,
    this.bypass = false,
    this.hintText,
    this.errorMessage = 'Field cannot be empty.',
    this.leading,
    this.trailing,
    this.backgroundColor = ThemeUtils.kDark,
    this.radius,
    this.border,
    this.headline,
    this.maxLength,
    this.inputType = TextInputType.text,
  });

  @override
  State<FieldComponent> createState() => FieldComponentState();
}

class FieldComponentState extends State<FieldComponent> {
  bool isHovered = false;

  String? errorMessage;

  late bool isSecure = widget.isSecure;
  late bool isEnlarged = widget.height > 60;

  @override
  void initState() {
    super.initState();

    /*widget.controller.addListener(() {
      if (widget.controller.text.isEmpty && widget.isRequired) {
        setState(() => errorMessage = validate());
      } else {
        if (errorMessage == null) return;
        setState(() => errorMessage = null);
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final content = Stack(
      alignment: Alignment.topLeft,
      children: [
        _buildInput(),
        if (widget.leading != null) ...[_buildLeading()],
        if (widget.trailing != null) ...[_buildTrailing()],
        if (widget.isSecure) ...[_buildSecure()],
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.headline != null) ...[
          widget.headline!,
          BoxComponent.height(5),
        ],
        _buildField(content),
        if (!widget.bypass && errorMessage != null) ...[_buildError()],
      ],
    );
  }

  Container _buildField(Stack content) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: widget.radius ?? BorderRadius.circular(8),
        border: widget.border ?? Border.all(color: ThemeUtils.kDark),
      ),
      child: content,
    );
  }

  Padding _buildInput() {
    bool isEnlarged = widget.height > 50;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        widget.leading != null ? 50 : 25,
        isEnlarged ? 10 : 0,
        isEnlarged ? 25 : 0,
        isEnlarged ? 10 : 0,
      ),
      child: _buildInputField(),
    );
  }

  Widget _buildError() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
      child: Text(errorMessage ?? '', style: StyleUtils.errorStyle),
    );
  }

  Positioned _buildSecure() {
    return Positioned(top: 5, right: 10, child: _buildSecureButton());
  }

  Positioned _buildLeading() {
    return Positioned(top: 10, left: 15, bottom: 10, child: widget.leading!);
  }

  Positioned _buildTrailing() {
    return Positioned(
      right: 0,
      child: ButtonComponent(
        width: 50,
        height: widget.height,
        backgroundColor: Colors.transparent,
        hoverColor: Colors.transparent,
        content: widget.trailing!.icon,
        onPressed: () {
          widget.trailing!.onPressed?.call();
        },
      ),
    );
  }

  IconButton _buildSecureButton() {
    return IconButton(
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: Icon(
        isSecure ? Icons.visibility_off : Icons.visibility,
        color: ThemeUtils.kPrimary,
      ),
      onPressed: () {
        setState(() => isSecure = !isSecure);
      },
    );
  }

  TextFormField _buildInputField() {
    return TextFormField(
      controller: widget.controller,
      obscureText: isSecure,
      maxLines: isEnlarged ? widget.height ~/ 25 : 1,
      style: StyleUtils.regularLightStyle,
      keyboardType: widget.inputType,
      decoration: _buildInputDecoration(),
      inputFormatters: [LengthLimitingTextInputFormatter(widget.maxLength)],
      onEditingComplete: () {},
      validator: (value) {
        String? error;
        if (widget.isRequired || (value != null && value.isNotEmpty)) {
          error = validate();
        }
        setState(() => errorMessage = error);
        return error;
      },
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      border: InputBorder.none,
      contentPadding:
          !isEnlarged ? EdgeInsets.zero : const EdgeInsets.only(top: 5),
      hintText: widget.hintText,
      hintStyle: StyleUtils.regularFadeLightStyle.copyWith(
        color: Colors.white30,
      ),
      labelStyle: StyleUtils.regularLightStyle,
      errorStyle: const TextStyle(color: Colors.transparent),
      alignLabelWithHint: false,
    );
  }

  String? validate() {
    return widget.validation.match(widget.controller.text);
  }
}
