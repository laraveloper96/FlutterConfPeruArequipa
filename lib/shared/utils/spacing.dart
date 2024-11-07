import 'package:flutter/widgets.dart';

class Spacing {
  Spacing._();

  ///zero = 0
  static const double zero = 0;

  ///xxs = 2
  static const double xxs = 2;

  ///xs = 4
  static const double xs = 4;

  ///sm = 8
  static const double sm = 8;

  ///sl = 12
  static const double sl = 12;

  ///md = 16
  static const double md = 16;

  ///lg = 24
  static const double lg = 24;

  ///xl = 32
  static const double xl = 32;

  ///xxl = 48
  static const double xxl = 48;
}

class VerticalSpace {
  const VerticalSpace._();

  ///xxs = 2
  static Widget xxs = const SizedBox(height: Spacing.xxs);

  ///xs = 4
  static Widget xs = const SizedBox(height: Spacing.xs);

  ///sm = 8
  static Widget sm = const SizedBox(height: Spacing.sm);

  ///sl = 12
  static Widget sl = const SizedBox(height: Spacing.sl);

  ///md = 16
  static Widget md = const SizedBox(height: Spacing.md);

  ///lg = 24
  static Widget lg = const SizedBox(height: Spacing.lg);

  ///xl = 32
  static Widget xl = const SizedBox(height: Spacing.xl);

  ///xxl = 48
  static Widget xxl = const SizedBox(height: Spacing.xxl);
}

class HorizontalSpace {
  HorizontalSpace._();

  ///xxs = 2
  static Widget xxs = const SizedBox(width: Spacing.xxs);

  ///xs = 4
  static Widget xs = const SizedBox(width: Spacing.xs);

  ///sm = 8
  static Widget sm = const SizedBox(width: Spacing.sm);

  ///sl = 12
  static Widget sl = const SizedBox(width: Spacing.sl);

  ///md = 16
  static Widget md = const SizedBox(width: Spacing.md);

  ///lg = 24
  static Widget lg = const SizedBox(width: Spacing.lg);

  ///xl = 32
  static Widget xl = const SizedBox(width: Spacing.xl);

  ///xxl = 48
  static Widget xxl = const SizedBox(width: Spacing.xxl);
}
