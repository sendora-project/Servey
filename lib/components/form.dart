import 'package:flutter/material.dart';

import 'box.dart';

class FormComponent extends StatefulWidget {
  final GlobalKey<FormState> handle;
  final List<Widget> components;
  final List<Widget> buttons;
  final bool interactable;

  const FormComponent({
    super.key,
    required this.handle,
    required this.components,
    required this.buttons,
    this.interactable = true,
  });

  @override
  State<FormComponent> createState() => _FormComponentState();
}

class _FormComponentState extends State<FormComponent> {
  @override
  Widget build(BuildContext context) => _buildForm();

  Form _buildForm() {
    return Form(key: widget.handle, child: _buildFormContent());
  }

  Padding _buildFormContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...widget.components,
          BoxComponent.bigHeight,
          ...widget.buttons,
        ],
      ),
    );
  }
}
