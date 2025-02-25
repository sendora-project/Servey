import 'package:flutter/material.dart';

import '../misc/selectable.dart';
import '../utils/style.dart';
import '../utils/theme.dart';
import 'box.dart';
import 'button.dart';

class SelectorComponent extends StatefulWidget {
  final List<SelectorItemComponent> items;
  final ValueNotifier valueNotifier;
  final ValueNotifier<bool> errorNotifier;
  final String errorMessage;

  const SelectorComponent({
    super.key,
    required this.items,
    required this.valueNotifier,
    this.errorMessage = 'You must select a value.',
    required this.errorNotifier,
  });

  @override
  State<SelectorComponent> createState() => _SelectorComponentState();
}

class _SelectorComponentState extends State<SelectorComponent> {
  @override
  Widget build(BuildContext context) => _buildSelector();

  Column _buildSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: widget.valueNotifier,
          builder: (context, value, child) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: widget.items.length,
              separatorBuilder: (context, index) => BoxComponent.smallHeight,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = widget.items.elementAt(index);
                return item.copyWith(value == item.selectable);
              },
            );
          },
        ),
        _buildError(),
      ],
    );
  }

  ValueListenableBuilder _buildError() {
    return ValueListenableBuilder(
      valueListenable: widget.errorNotifier,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 25, top: 4),
          child: Text(
            value ? widget.errorMessage : '',
            style: StyleUtils.errorStyle,
          ),
        );
      },
    );
  }
}

class SelectorItemComponent extends StatefulWidget {
  final Selectable selectable;
  final Function() onPressed;
  final bool isSelected;

  const SelectorItemComponent({
    super.key,
    required this.selectable,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  State<SelectorItemComponent> createState() => _SelectorItemComponentState();

  SelectorItemComponent copyWith(bool? selected) {
    return SelectorItemComponent(
      key: key,
      selectable: selectable,
      onPressed: onPressed,
      isSelected: selected ?? false,
    );
  }
}

class _SelectorItemComponentState extends State<SelectorItemComponent> {
  @override
  Widget build(BuildContext context) => _buildItem();

  ButtonComponent _buildItem() {
    return ButtonComponent(
      height: 50,
      backgroundColor:
          widget.isSelected ? ThemeUtils.kPrimary : Colors.transparent,
      hoverColor: Colors.grey.shade300,
      border: Border.all(color: ThemeUtils.kPrimary),
      radius: BorderRadius.circular(15),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [BoxComponent.mediumWidth, _buildLabel()],
      ),
      onPressed: () {
        widget.onPressed.call();
      },
    );
  }

  Text _buildLabel() {
    return Text(
      widget.selectable.label,
      style:
          widget.isSelected
              ? StyleUtils.regularLightStyle
              : StyleUtils.regularDarkStyle,
    );
  }
}
