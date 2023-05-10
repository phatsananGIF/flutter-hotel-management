import 'package:flutter/material.dart';

import '../../core/styles/color.dart';

class BaseContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const BaseContainer({
    Key? key,
    required this.child,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          child,
          if (this.isLoading)
            WillPopScope(
              onWillPop: () => Future.value(false),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Color(PRIMARY700_COLOR),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
