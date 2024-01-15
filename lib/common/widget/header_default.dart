import 'package:paperweft/common/widget/icon_with_counter.dart';
import 'package:paperweft/core/assets/app_assets.dart';
import 'package:paperweft/core/style/app_color.dart';
import 'package:paperweft/core/style/app_typography.dart';
import 'package:flutter/material.dart';

class HeaderDefault extends StatelessWidget implements PreferredSizeWidget {
  const HeaderDefault(
      {Key? key,
      this.title,
      this.leading,
      this.pressLeft,
      this.icoLeftSrc,
      this.icoFirstRightSrc,
      this.icoSecondRightSrc,
      this.pressFirstRight,
      this.numFirstOf,
      this.visible,
      this.itemColor,
      this.numSecondOf,
      this.elevation,
      this.actionLabel,
      this.pressActionLabel,
      this.actionLabelColor,
      this.pressSecondRight,
      this.icoSecondRightHeight,
      this.icoFirstRightHeight,
      this.icoLeftHeight,
      this.titleStyle,
      this.boxCountHeight,
      this.boxCountWidth,
      this.boxCountColor,
      this.boxCountLabelColor,
      this.boxCountFontSize,
      this.centerTitle,
      this.icoFirstRightColor,
      this.icoSecondRightColor,
      this.leadingColor,
      this.backgroundColor,
      this.bottom})
      : super(key: key);

  final String? title;
  final bool? centerTitle;
  final TextStyle? titleStyle;
  final bool? leading;
  final double? elevation;
  final Color? backgroundColor;
  final Color? itemColor;
  final Color? leadingColor;
  final Color? icoFirstRightColor;
  final Color? icoSecondRightColor;
  final Color? actionLabelColor;
  final int? numFirstOf;
  final int? numSecondOf;
  final bool? visible;
  final String? icoLeftSrc;
  final String? icoFirstRightSrc;
  final String? icoSecondRightSrc;
  final String? actionLabel;
  final GestureTapCallback? pressActionLabel;
  final GestureTapCallback? pressLeft;
  final GestureTapCallback? pressFirstRight;
  final GestureTapCallback? pressSecondRight;
  final double? icoSecondRightHeight;
  final double? icoFirstRightHeight;
  final double? icoLeftHeight;
  final double? boxCountHeight;
  final double? boxCountWidth;
  final Color? boxCountColor;
  final Color? boxCountLabelColor;
  final double? boxCountFontSize;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
      child: Visibility(
          visible: visible ?? true,
          child: AppBar(
            backgroundColor: backgroundColor ?? AppColors.white,
            elevation: elevation,
            automaticallyImplyLeading: leading == false ? false : true,
            leading: leading != false
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconWithCounter(
                      svgSrc: icoLeftSrc ?? AppAssets.arrowBack,
                      itemColor: itemColor ?? AppColors.eerieblack,
                      numOfitem: numSecondOf ?? 0,
                      press: pressLeft ?? () {},
                      icoHeight: icoLeftHeight ?? 15,
                    ))
                : null,
            centerTitle: centerTitle ?? true,
            title: title != null
                ? Text(title ?? "Header Title",
                    style: titleStyle ??
                        AppTypography.title1(
                            color: itemColor ?? AppColors.eerieblack))
                : null,
            actions: [
              if (icoFirstRightSrc != null)
                IconWithCounter(
                  svgSrc: icoFirstRightSrc ?? AppAssets.burgerMenuHeader1,
                  numOfitem: numFirstOf ?? 0,
                  press: pressFirstRight ?? () {},
                  itemColor: icoFirstRightColor ?? itemColor,
                  icoHeight: icoFirstRightHeight ?? 20,
                  boxCountColor: boxCountColor,
                  boxCountWidth: boxCountWidth,
                  boxCountFontSize: boxCountFontSize,
                  boxCountHeight: boxCountHeight,
                  boxCountLabelColor: boxCountLabelColor,
                ),
              if (icoSecondRightSrc != null)
                IconWithCounter(
                  svgSrc: icoSecondRightSrc ?? AppAssets.burgerMenuHeader1,
                  numOfitem: numSecondOf ?? 0,
                  press: pressSecondRight ?? () {},
                  icoHeight: icoSecondRightHeight ?? 20,
                  boxCountColor: boxCountColor,
                  boxCountWidth: boxCountWidth,
                  itemColor: icoSecondRightColor ?? itemColor,
                  boxCountFontSize: boxCountFontSize,
                  boxCountHeight: boxCountHeight,
                  boxCountLabelColor: boxCountLabelColor,
                ),
              if (actionLabel != null)
                Container(
                    margin: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 10.0),
                    child: Stack(children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: pressActionLabel ?? () {},
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                            height: 45,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: Text(actionLabel ?? "Action",
                                    style: AppTypography.subtitle4(
                                        color: actionLabelColor ??
                                            AppColors.warning))),
                          ),
                        ),
                      )
                    ])),
              const SizedBox(width: 5),
            ],
            bottom: bottom,
          )),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(bottom != null ? (kToolbarHeight * 1.8) : kToolbarHeight);
}
