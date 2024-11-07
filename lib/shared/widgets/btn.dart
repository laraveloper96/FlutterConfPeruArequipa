import 'package:flutter/material.dart';
import 'package:nimbuz_arm_robotic/shared/utils/utils.dart';

class BtnIcon extends StatelessWidget {
  const BtnIcon({
    required this.icon,
    required this.label,
    this.fill = false,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final bool fill;
  final VoidCallback? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white.withOpacity(.25),
            border: Border.all(
              color: Colors.white,
              width: 0.4,
            ),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(30),
                child: Ink(
                  width: 80,
                  height: 30,
                  child: Center(
                    child: Icon(icon),
                  ),
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  // color: Colors.white,
                  color: CColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BtnCircular extends StatelessWidget {
  const BtnCircular({
    required this.icon,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3.5),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Ink(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Icon(
              icon,
              color: CColors.black,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class BtnRobot extends StatelessWidget {
  const BtnRobot({
    required this.icon,
    required this.label,
    required this.enable,
    required this.status,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final bool status;
  final bool enable;
  final VoidCallback? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          borderRadius: BorderRadius.circular(30),
          color: enable
              ? CColors.primaryColor
              : CColors.primaryColor.withOpacity(.2),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(30),
            child: Ink(
              width: 80,
              height: 40,
              child: Center(
                child: Icon(
                  icon,
                  color: CColors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              width: 7,
              height: 7,
              margin: const EdgeInsets.only(left: 3),
              decoration: BoxDecoration(
                color: status ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
