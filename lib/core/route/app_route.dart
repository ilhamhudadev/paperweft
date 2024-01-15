import 'package:paperweft/core/route/route_constant.dart';
import 'package:paperweft/main.dart';
import 'package:paperweft/module/auth/screen/auth_screen.dart';
import 'package:paperweft/module/auth/screen/signup_screen.dart';
import 'package:paperweft/module/bottom/screen/bottom_screen.dart';
import 'package:paperweft/module/house/screen/house_screen.dart';
import 'package:paperweft/module/you/screen/you_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static final all = [
    GetPage(name: RouteConstant.houseScreen, page: () => BottomScreen()),
    GetPage(name: RouteConstant.authScreen, page: () => AuthScreen()),
    // GetPage(name: RouteConstant.exploreScreen, page: () => ToDoListScreen()),
    GetPage(name: RouteConstant.youScreen, page: () => YouScreen()),
    GetPage(name: RouteConstant.signUpScreen, page: () => SignUpScreen()),
  ];
}
