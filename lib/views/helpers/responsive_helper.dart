import 'package:flutter/material.dart';
import 'package:riverpod_app/utils/build_context_x.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    Key? key,
    required this.mobile,
    required this.desktop,
  }) : super(key: key);
  final Widget mobile;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    if (context.screenWidth < 720) {
      return mobile;
    } else {
      return desktop;
    }
  }
}
