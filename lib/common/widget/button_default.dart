import 'package:paperweft/core/assets/app_assets.dart';
import 'package:flutter/material.dart';

class ButtonDefault extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final TextStyle textStyle;
  final String title;
  final String? leftIcon;
  final IconData? rightIcon;
  final Color iconColor;
  final Color titleColor;
  final Color backgroundColor;
  final Color borderRadiusColor;
  final VoidCallback onTap;

  const ButtonDefault({
    Key? key,
    this.height = 50.0,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(5.0),
    this.borderRadius = 8.0,
    required this.textStyle,
    required this.title,
    this.leftIcon,
    this.rightIcon,
    this.iconColor = Colors.white,
    this.titleColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.borderRadiusColor = Colors.transparent,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderRadiusColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon != null)
              // Icon(
              //   leftIcon,
              //   color: iconColor,
              // ),
              SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(leftIcon ?? AppAssets.googlePng,
                      fit: BoxFit.fitHeight)),
            const SizedBox(
              width: 10,
            ),
            if (leftIcon != null) const SizedBox(width: 8.0),
            Text(
              title,
              style: textStyle.copyWith(color: titleColor),
            ),
            if (rightIcon != null) const SizedBox(width: 8.0),
            if (rightIcon != null)
              Icon(
                rightIcon,
                color: iconColor,
              ),
          ],
        ),
      ),
    );
  }
}
