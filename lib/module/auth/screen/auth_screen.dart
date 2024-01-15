import 'package:paperweft/common/widget/button_default.dart';
import 'package:paperweft/common/widget/header_default.dart';
import 'package:paperweft/core/assets/app_assets.dart';
import 'package:paperweft/core/route/route_constant.dart';
import 'package:paperweft/core/style/app_size.dart';
import 'package:paperweft/core/style/app_typography.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperweft/module/auth/controller/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (AuthController controller) {
        return const Scaffold(body: LoginPage());
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      appBar: HeaderDefault(
        title: "",
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Hello",
                  style: AppTypography.headline3(),
                )),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Let's sign you in.",
                  style: AppTypography.body2(),
                )),
            _buildUsernameField(),
            const SizedBox(height: 16.0),
            _buildPasswordField(),
            const SizedBox(height: 16.0),
            Center(
                child: ButtonDefault(
              height: 50.0,
              width: AppSize.screenWidth * 0.8,
              margin: EdgeInsets.all(10.0),
              borderRadius: 50.0,
              textStyle: TextStyle(fontSize: 18.0),
              title: 'Sign In',
              iconColor: Colors.white,
              titleColor: Colors.white,
              backgroundColor: Colors.black,
              borderRadiusColor: Colors.black,
              onTap: () {
                // Implement onTap logic here
              },
            )),
            Center(
                child: ButtonDefault(
              height: 50.0,
              leftIcon: AppAssets.googlePng,
              width: AppSize.screenWidth * 0.8,
              margin: EdgeInsets.all(10.0),
              borderRadius: 50.0,
              textStyle: TextStyle(fontSize: 18.0),
              title: 'Sign in with Google',
              iconColor: Colors.black,
              titleColor: Colors.black,
              backgroundColor: Colors.white,
              borderRadiusColor: Colors.black,
              onTap: () {
                // Implement onTap logic here
              },
            )),
            Center(child: footerSection())
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return Container(
        decoration: const BoxDecoration(color: Colors.white70),
        padding: const EdgeInsets.all(10),
        child: const TextField(
          decoration: InputDecoration(
            labelText: 'Username',
            focusColor: Colors.black,
            labelStyle: TextStyle(color: Colors.black),
            icon: Icon(
              Icons.person_2_outlined,
              color: Colors.black,
            ),
          ),
        ));
  }

  Widget _buildPasswordField() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white54, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(10),
        child: const TextField(
          obscureText: true,
          decoration: InputDecoration(
            focusColor: Colors.black,
            suffixIcon: Icon(
              Icons.remove_red_eye_rounded,
              color: Colors.black,
            ),
            labelText: 'Password',
            fillColor: Colors.black,
            labelStyle: TextStyle(color: Colors.black),
            icon: Icon(
              Icons.lock_outline,
              color: Colors.black,
            ),
          ),
        ));
  }

  Widget footerSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Don't have account yet? ",
            style: AppTypography.caption(),
            children: [
              TextSpan(
                text: "Sign Up",
                style: AppTypography.button2(),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(RouteConstant.signUpScreen);
                  },
              ),
            ]),
      ),
    );
  }
}
