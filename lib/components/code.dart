import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/style.dart';
import 'box.dart';

class CodeComponent extends StatefulWidget {
  final int length;
  final void Function(String code) onDone;

  const CodeComponent({
    super.key,
    required this.length,
    required this.onDone,
  });

  @override
  State<CodeComponent> createState() => _CodeComponentState();
}

class _CodeComponentState extends State<CodeComponent> {
  late final List<FocusNode> nodes;
  late final List<TextEditingController> controllers;

  bool codeInvalid = false;

  @override
  void initState() {
    super.initState();

    nodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );
    controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );

    for (int i = 0; i < widget.length; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1) {
          if (i < widget.length - 1) {
            nodes[i + 1].requestFocus();
            controllers[i + 1].clear();
          } else {
            nodes[i].unfocus();

            final code = _constructCode();
            if (code.length != widget.length) {
              setState(() => codeInvalid = true);
              for (final controller in controllers) {
                controller.clear();
              }
              return;
            }

            setState(() => codeInvalid = false);

            widget.onDone.call(code);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.length,
            (index) => SizedBox(
              width: 50,
              child: _buildTextfield(index),
            ),
          ),
        ),
        BoxComponent.smallHeight,
        Text(
          codeInvalid ? 'Oops, something went wrong!' : '',
          style: StyleUtils.errorStyle,
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (int i = 0; i < widget.length; i++) {
      nodes[i].dispose();
      controllers[i].dispose();
    }
  }

  TextFormField _buildTextfield(int index) {
    return TextFormField(
      controller: controllers[index],
      focusNode: nodes[index],
      maxLength: 1,
      keyboardType: TextInputType.number,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      style: StyleUtils.regularDarkStyle,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(20),
        counterText: '',
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }

  String _constructCode() {
    String otp = '';
    for (final controller in controllers) {
      otp += controller.text;
    }
    return otp;
  }
}
