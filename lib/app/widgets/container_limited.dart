import 'package:ecomm/app/constants/constants.dart';
import 'package:flutter/material.dart';

class ContainerLimited extends StatelessWidget {
  const ContainerLimited(
      {super.key, required this.child, this.paddingValue = AppSpacing.md});

  final Widget child;
  final double paddingValue;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.all(paddingValue),
          child: child,
        ),
      ),
    );
  }
}
