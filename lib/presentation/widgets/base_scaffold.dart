import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/styles/color.dart';
import '../../core/styles/screen_dimensions.dart';
import '../../core/styles/sarabun_font.dart';

class BaseScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final Color? titleColor;
  final bool isLoading;
  final List<Widget>? actions;
  final bool hideBackButton;
  final SystemUiOverlayStyle? systemOverlayStyle;

  const BaseScaffold({
    Key? key,
    this.title,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.appBarBackgroundColor,
    this.titleColor,
    this.isLoading = false,
    this.actions,
    this.hideBackButton = false,
    this.systemOverlayStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            backgroundColor: backgroundColor ?? Colors.white,
            appBar: AppBar(
              systemOverlayStyle: this.systemOverlayStyle ?? null,
              backgroundColor: this.appBarBackgroundColor ?? Colors.white,
              elevation: 0,
              leading: this.hideBackButton
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        if (ModalRoute.of(context)?.canPop ?? false) {
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: titleColor ?? Color(SECOND900_COLOR),
                        size: SCDimens.dimen24,
                      ),
                    ),
              centerTitle: true,
              title: title != null
                  ? Text(
                      this.title!,
                      style: SBFont.medium16.copyWith(
                        color: titleColor ?? Color(SECOND900_COLOR),
                      ),
                    )
                  : null,
              actions: this.actions,
            ),
            body: this.body,
            floatingActionButton: this.floatingActionButton,
            floatingActionButtonLocation: this.floatingActionButtonLocation,
            bottomNavigationBar: this.bottomNavigationBar,
          ),
        ),
        if (this.isLoading)
          WillPopScope(
            onWillPop: () => Future.value(false),
            child: Container(
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Color(PRIMARY_COLOR),
              ),
            ),
          ),
      ],
    );
  }
}
