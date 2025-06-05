import 'package:flutter/material.dart';

import '../animation/animation/animation_transaction.dart';

extension NavigatorExtensions on BuildContext {
  void pushWithScale(Widget page) {
    Navigator.push(this, ScaleTransitionPage(page));
  }

  void pushReplacementWithScale(Widget page) {
    Navigator.pushReplacement(this, ScaleTransitionPage(page));
  }

  void pushAndRemoveUntilWithScale(Widget page) {
    Navigator.pushAndRemoveUntil(
      this,
      ScaleTransitionPage(page),
      (route) => false,
    );
  }
}
