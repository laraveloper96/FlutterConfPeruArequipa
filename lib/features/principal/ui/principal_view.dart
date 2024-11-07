import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimbuz_arm_robotic/core/utils/debouncer.dart';
import 'package:nimbuz_arm_robotic/features/principal/ui/widgets/left_panel_controls.dart';
import 'package:nimbuz_arm_robotic/features/principal/ui/widgets/slider_controls.dart';
import 'package:nimbuz_arm_robotic/shared/utils/ccolors.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  late Debouncer _debouncer;
  @override
  void initState() {
    super.initState();
    _debouncer = context.read<Debouncer>();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      CColors.gradientSecondary,
                      CColors.gradientPrimary,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      CColors.black.withOpacity(.4),
                      CColors.black.withOpacity(.05),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: [
                  const LeftPanelCtrls(),
                  SliderCtrls(
                    debouncer: _debouncer,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
