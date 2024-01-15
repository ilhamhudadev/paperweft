import 'package:paperweft/core/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWithCounter extends StatelessWidget {
  const IconWithCounter({
    Key? key,
    required this.svgSrc,
    this.numOfitem = 0,
    required this.press,
    this.itemColor,
    this.icoHeight,
    this.boxCountHeight,
    this.boxCountWidth,
    this.boxCountColor,
    this.boxCountLabelColor,
    this.boxCountFontSize,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final Color? itemColor;
  final double? icoHeight;
  final GestureTapCallback press;
  final double? boxCountHeight;
  final double? boxCountWidth;
  final Color? boxCountColor;
  final Color? boxCountLabelColor;
  final double? boxCountFontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: FractionalOffset.center,
        // margin: const EdgeInsets.only(
        //     top: 10.0, bottom: 10.0, left: 1.5, right: 1.5),
        child: Stack(children: [
          Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: press,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      alignment: FractionalOffset.center,
                      margin:
                          EdgeInsets.only(right: numOfitem != 0 ? 5.0 : 0.0),
                      padding: const EdgeInsets.only(
                          top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(svgSrc,
                          height: icoHeight ?? 21,
                          color: itemColor ?? AppColors.eerieblack),
                    ),
                    if (numOfitem != 0)
                      Positioned(
                        top: 10,
                        right: -2,
                        child: Container(
                          height: boxCountHeight ?? 20,
                          width: boxCountWidth ?? 20,
                          decoration: BoxDecoration(
                            color: boxCountColor ?? const Color(0xFFFF4848),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "$numOfitem",
                              style: TextStyle(
                                fontSize: boxCountFontSize ?? 10,
                                height: 1,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ))
        ]));
  }
}
