import 'package:flutter/material.dart';

import '../utils/theme.dart';

class SwitchComponment extends StatelessWidget {
  final void Function(bool) onSwitch;
  final bool active;

  const SwitchComponment({
    super.key,
    required this.active,
    required this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      thumbColor: const WidgetStatePropertyAll<Color>(Colors.white12),
      activeColor: ThemeUtils.kPrimary,
      inactiveTrackColor: Colors.grey.shade800,
      value: active,
      onChanged: (value) {
        onSwitch.call(value);
      },
    );
  }
}
