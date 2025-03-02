import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool showBackButton;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final bool resizeToAvoidBottomInset;
  final Widget? drawer;
  final Widget? endDrawer;

  const BasePage({
    Key? key,
    this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.showBackButton = true,
    this.backgroundColor,
    this.appBar,
    this.resizeToAvoidBottomInset = true,
    this.drawer,
    this.endDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ??
          (title != null
              ? AppBar(
                  title: Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                  leading: showBackButton
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      : null,
                  actions: actions,
                )
              : null),
      body: SafeArea(
        child: body,
      ),
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      drawer: drawer,
      endDrawer: endDrawer,
    );
  }
} 