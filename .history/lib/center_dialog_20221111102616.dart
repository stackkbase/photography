import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

import 'responsive_widget.dart';

class CenterDialog extends StatelessWidget {
  CenterDialog({Key? key, required this.child, this.width, this.height})
      : super(key: key);

  final double? width;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: DismissiblePage(
        startingOpacity: 0.0,
        onDismissed: () => Navigator.of(context).pop(),
        isFullScreen: ResponsiveWidget.isSmallScreen(context),
        direction: DismissiblePageDismissDirection.horizontal,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveWidget.isSmallScreen(context)
                ? double.infinity
                : width ?? 800,
            maxHeight: ResponsiveWidget.isSmallScreen(context)
                ? double.infinity
                : height ?? 800,
          ),
          child: child,
        ),
      ),
    );
  }
}
