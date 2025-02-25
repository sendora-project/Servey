import 'package:flutter/material.dart';

import '../utils/config.dart';
import '../utils/style.dart';
import 'box.dart';

class WatermarkComponent extends StatelessWidget {
  const WatermarkComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) => _buildWatermark();

  Column _buildWatermark() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildWatermarktext(),
        BoxComponent.height(5),
        _buildVersionText()
      ],
    );
  }

  Text _buildWatermarktext() {
    return const Text(
      ConfigUtils.kWatermark,
      style: StyleUtils.smallFadeDarkStyle,
      textAlign: TextAlign.center,
    );
  }

  Text _buildVersionText() {
    return const Text(
      'Version ${ConfigUtils.kAppVersion}',
      style: StyleUtils.smallFadeDarkStyle,
      textAlign: TextAlign.center,
    );
  }
}
