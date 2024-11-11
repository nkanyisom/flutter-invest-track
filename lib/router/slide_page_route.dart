import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder<Widget> {
  SlidePageRoute({required this.page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            const Offset begin = Offset(1.0, 0.0);
            const Offset end = Offset.zero;
            const Curve curve = Curves.easeInOut;

            final Animatable<Offset> tween =
                Tween<Offset>(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
            final Animation<Offset> offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
  final Widget page;
}
