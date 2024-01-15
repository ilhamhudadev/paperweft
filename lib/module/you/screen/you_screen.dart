import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperweft/module/you/controller/you_controller.dart';

class YouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<YouController>(
      init: YouController(),
      builder: (YouController controller) {
        return Scaffold();
      },
    );
  }
}
