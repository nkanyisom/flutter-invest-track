import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    required this.child,
    required this.backgroundColor,
    super.key,
  });

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding around the text.
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        // Background color.
        color: backgroundColor,
        // Rounded corners.
        borderRadius: BorderRadius.circular(8),
        // Optional: Border color to match background.
        border: Border.all(color: backgroundColor),
      ),
      // The child widget (e.g., the text).
      child: child,
    );
  }
}
