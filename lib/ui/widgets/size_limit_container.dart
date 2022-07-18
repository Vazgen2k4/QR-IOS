import 'package:flutter/material.dart';

class SizeLimitContainer extends StatelessWidget {
  final Widget? child;
  final double verticalPadding;
  final double horizontalPadding;
  final double maxWidth;

  final double minWidth;

  const SizeLimitContainer({
    Key? key,
    this.child,
    this.verticalPadding = 0,
    this.horizontalPadding = 15,
    this.maxWidth = 768,
    this.minWidth = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: verticalPadding,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth + 2 * horizontalPadding,
            minWidth: minWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
