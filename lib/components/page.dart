import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/config.dart';
import '../utils/theme.dart';
import 'box.dart';

class PageComponent extends StatelessWidget {
  final String name;
  final PreferredSizeWidget? appBar;
  final Widget? sideBar;
  final Widget? bottomBar;
  final Color backgroundColor;
  final List<Widget> content;

  const PageComponent({
    super.key,
    required this.name,
    required this.content,
    this.backgroundColor = ThemeUtils.kBackground,
    this.appBar,
    this.sideBar,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: '${ConfigUtils.kProjectName} - $name',
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: appBar,
      bottomNavigationBar: bottomBar,
      body: _buildLayout(context),
    );
  }

  Stack _buildLayout(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
            child: Column(children: [...content]),
          ),
        ),
        if (sideBar != null) ...[_buildSidebar()],
      ],
    );
  }

  Positioned _buildSidebar() {
    return Positioned(left: 0, top: 32, child: sideBar!);
  }
}
