
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:paperweft/module/trends/controller/trends_controller.dart';
  
  class TrendsScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return GetBuilder<TrendsController>(
        init: TrendsController(),
        builder: (TrendsController controller) {
          return Scaffold();
        },
      );
    }
  }