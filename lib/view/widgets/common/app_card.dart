import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final double? elevation;
  final VoidCallback? onTap;

  const AppCard({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.boxShadow,
    this.border,
    this.elevation,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        margin: margin ?? const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).cardColor,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          boxShadow: boxShadow ?? [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: border,
        ),
        child: child,
      ),
    );
  }
} 