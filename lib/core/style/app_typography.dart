import 'package:paperweft/core/style/app_color.dart';
import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle title({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 14.0,
      fontFamily: 'nunito',
      letterSpacing: 0.12,
      height: 1.4,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle caption({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 12.0,
      fontFamily: 'nunito',
      letterSpacing: 0.12,
      height: 1.33,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  /// Headline 1 Typography
  /// use [headline1]
  ///
  /// Send parameter[color]
  ///
  /// example headline1(Color(0xffCCCCCC))
  static TextStyle headline1({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 64.0,
      fontFamily: 'Nunito',
      letterSpacing: 0.64,
      height: 1.4,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  /// Headline 2 Typography
  /// Use [headline2]
  ///
  /// Send parameter[color]
  ///
  /// Example headline2(Color(0xffCCCCCC))
  static TextStyle headline2({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 52.0,
      fontFamily: 'Nunito',
      height: 1.4,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  /// Headline 3 Typography
  /// Use [headline3]
  ///
  /// Send parameter[color]
  ///
  /// Example headline3(Color(0xffCCCCCC))
  static TextStyle headline3({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 40.0,
      fontFamily: 'Nunito',
      letterSpacing: 0.4,
      height: 1.4,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  /// Headline 4 Typography
  /// Use [headline4]
  ///
  /// Send parameter[color]
  ///
  /// Example headline4(Color(0xffCCCCCC))
  static TextStyle headline4({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 32.0,
      fontFamily: 'Nunito',
      height: 1.34,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  /// Headline 5 Typography
  /// Use [headline5]
  ///
  /// Send parameter[color]
  ///
  /// Example headline5(Color(0xffCCCCCC))
  static TextStyle headline5({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 24.0,
      fontFamily: 'Nunito',
      letterSpacing: 0.24,
      height: 1.34,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  /// Headline 6 Typography
  /// Use [headline6]
  ///
  /// Send parameter[color]
  ///
  /// Example headline6(Color(0xffCCCCCC))
  static TextStyle headline6({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 20.0,
      fontFamily: 'Nunito',
      height: 1.2,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  /// Title 1 Typography
  /// Use [title1]
  ///
  /// Send parameter[color]
  ///
  /// Example title1(Color(0xffCCCCCC))
  static TextStyle title1({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 18.0,
      fontFamily: 'Nunito',
      letterSpacing: 0.18,
      height: 1.3,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  /// Title 2 Typography
  /// Use [title2]
  ///
  /// Send parameter[color]
  ///
  /// Example title2(Color(0xffCCCCCC))
  static TextStyle title2({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 16.0,
      fontFamily: 'Nunito',
      letterSpacing: 0.16,
      height: 1.4,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  /// Title 3 Typography
  /// Use [title3]
  ///
  /// Send parameter[color]
  ///
  /// Example title3(Color(0xffCCCCCC))
  static TextStyle title3({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 14.0,
      fontFamily: 'Nunito',
      letterSpacing: 0.14,
      height: 1.4,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  /// Title 4 Typography
  /// Use [title4]
  ///
  /// Send parameter[color]
  ///
  /// Example title4(Color(0xffCCCCCC))
  static TextStyle title4({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 12.0,
      fontFamily: 'Nunito',
      letterSpacing: 0.12,
      height: 1.3,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  /// Title 5 Typography
  /// Use [title5]
  ///
  /// Send parameter[color]
  ///
  /// Example title5(Color(0xffCCCCCC))
  static TextStyle title5({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 11.0,
      fontFamily: 'Nunito',
      letterSpacing: 0.11,
      height: 1.5,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  /// Subtitle 1 Typography
  /// Use [subtitle1]
  ///
  /// Send parameter[color]
  ///
  /// Example subtitle1(Color(0xffCCCCCC))
  static TextStyle subtitle1({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.16,
      height: 1.4,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  /// Subtitle 2 Typography
  /// Use [subtitle2]
  ///
  /// Send parameter[color]
  ///
  /// Example subtitle2(Color(0xffCCCCCC))
  static TextStyle subtitle2({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.14,
      height: 1.4,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  /// Subtitle 3 Typography
  /// Use [subtitle3]
  ///
  /// Send parameter[color]
  ///
  /// Example subtitle3(Color(0xffCCCCCC))
  static TextStyle subtitle3({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.16,
      height: 1.4,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  /// Subtitle 4 Typography
  /// Use [subtitle4]
  ///
  /// Send parameter[color]
  ///
  /// Example subtitle4(Color(0xffCCCCCC))
  static TextStyle subtitle4({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.14,
      height: 1.4,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle subtitle5({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.14,
      height: 0,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  /// Button 1 Typography
  /// Use [button1]
  ///
  /// Send parameter[color]
  ///
  /// Example button1(Color(0xffCCCCCC))
  static TextStyle button1({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      letterSpacing: 1.68,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  /// Button 3 Typography
  /// Use [button2]
  ///
  /// Send parameter[color]
  ///
  /// Example button2(Color(0xffCCCCCC))
  static TextStyle button2({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 12.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.12,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  /// Hyperlink 1 Typography
  /// Use [hyperlink1]
  ///
  /// Send parameter[color]
  ///
  /// Example hyperlink1(Color(0xffCCCCCC))
  static TextStyle hyperlink1({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.14,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  /// Hyperlink 2 Typography
  /// Use [hyperlink2]
  ///
  /// Send parameter[color]
  ///
  /// Example hyperlink2(Color(0xffCCCCCC))
  static TextStyle hyperlink2({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 12.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.12,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  /// Body 1 Typography
  /// Use [body1]
  ///
  /// Send parameter[color]
  ///
  /// Example body1(Color(0xffCCCCCC))
  static TextStyle body1({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 16.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.16,
      height: 1.4,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  /// Body 2 Typography
  /// Use [body2]
  ///
  /// Send parameter[color]
  ///
  /// Example body2(Color(0xffCCCCCC))
  static TextStyle body2({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.14,
      height: 1.4,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle body3({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.14,
      height: 1.2,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle body4({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 20.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.14,
      height: 1,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle body5({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 14.0,
      fontFamily: 'Roboto',
      letterSpacing: 0.14,
      height: 1.6,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  /// Overline Typography
  /// Use [overline]
  ///
  /// Send parameter[color]
  ///
  /// Example overline(Color(0xffCCCCCC))
  static TextStyle overline({Color color = AppColors.bodytext}) {
    return TextStyle(
      fontSize: 10.0,
      fontFamily: 'Roboto',
      letterSpacing: 1,
      height: 1.4,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }
}
