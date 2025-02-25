import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../misc/selectable.dart';
import '../utils/style.dart';
import '../utils/theme.dart';
import 'box.dart';

class DropdownComponent extends StatefulWidget {
  final double? width, height;
  final Selectable? firstItem;
  final Iterable<Selectable> items;
  final bool isRequired;
  final bool force;
  final String errorText;
  final ValueNotifier<Selectable?> notifier;
  final Widget? headline;

  const DropdownComponent({
    super.key,
    this.firstItem,
    required this.items,
    this.width,
    this.height,
    this.isRequired = true,
    this.force = false,
    this.errorText = 'Your must select a value.',
    required this.notifier,
    this.headline,
  });

  @override
  State<DropdownComponent> createState() => _DropdownComponentState();
}

class _DropdownComponentState extends State<DropdownComponent> {
  late final List<Selectable> items = widget.items.map((e) => e).toList();

  late Selectable currValue;
  String? errorText;

  @override
  void initState() {
    super.initState();

    if (widget.firstItem != null) {
      final item = widget.firstItem!;
      if (items.contains(item)) return;
      items.insert(0, item);
    }

    currValue = widget.notifier.value ?? items.first;

    if (widget.force) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.notifier.value = currValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) => _buildDropdown();

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.headline != null) ...[
          widget.headline!,
          BoxComponent.height(5),
        ],
        _buildField(),
        /*if (!widget.force) ...[
          BoxComponent.height(4),
          _buildError(),
        ]*/
      ],
    );
  }

  Container _buildField() {
    return Container(
      decoration: BoxDecoration(
        color: ThemeUtils.kDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 18, 0),
        child: DropdownButtonFormField(
          value: currValue.label,
          icon: const Icon(
            FontAwesomeIcons.arrowDown,
            color: Colors.white54,
          ),
          decoration: _buildInputDecoration(),
          borderRadius: BorderRadius.circular(25),
          focusColor: Colors.transparent,
          items: items.map((item) {
            return _buildItem(item);
          }).toList(),
          onChanged: (value) {
            setState(() {
              currValue = items.firstWhere((e) => e.label == value);
              errorText = null;
            });

            if (currValue == items.first && !widget.force) {
              widget.notifier.value = null;
            } else {
              widget.notifier.value = currValue;
            }
          },
          validator: (value) => _handleValidation(value.toString()),
        ),
      ),
    );
  }

  DropdownMenuItem<String> _buildItem(Selectable item) {
    final style = widget.force
        ? StyleUtils.regularLightStyle
        : currValue == items.first
            ? StyleUtils.regularFadeLightStyle.copyWith(color: Colors.white30)
            : StyleUtils.regularLightStyle;
    final label = item.label;

    return DropdownMenuItem(
      value: label,
      child: Text(label, style: style),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: ThemeUtils.kDark,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(color: ThemeUtils.kBackground),
    );
  }

  InputDecoration _buildInputDecoration() {
    return const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,
      errorStyle: TextStyle(color: Colors.transparent),
      alignLabelWithHint: true,
    );
  }

  Padding _buildError() {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(
        errorText ?? '',
        style: StyleUtils.errorStyle,
      ),
    );
  }

  String? _handleValidation(String? value) {
    String? error;
    try {
      if (widget.isRequired) {
        error = validateField();
      } else {
        error = value != null && value.isNotEmpty ? validateField() : null;
      }
      return error;
    } finally {
      setState(() => errorText = error);
    }
  }

  String? validateField() {
    if (widget.force) return null;
    return currValue == items.first ? widget.errorText : null;
  }
}
