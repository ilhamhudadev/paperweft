import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:paperweft/core/style/app_color.dart';
import 'package:paperweft/core/style/app_typography.dart';
import 'package:paperweft/module/bottom/controller/bottom_controller.dart';
import 'package:paperweft/module/house/screen/edit_article.dart';
import 'package:paperweft/module/house/screen/house_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperweft/module/note/screen/note_screen.dart';
import 'package:paperweft/module/todolist/screen/todolist_screen.dart';

class BottomScreen extends StatelessWidget {
  const BottomScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomController>(
      init: BottomController(),
      builder: (BottomController controller) {
        return Scaffold(
          body: Obx(() => IndexedStack(
                index: controller.bottomNavIndex.value,
                children: [
                  NoteScreen(),
                  ToDoListScreen(),
                  Container(
                    // color: Colors.red,
                    child: Center(child: Text("Profile Screen")),
                  ),

                  // Replace the following with your actual profile screen widget
                  Container(
                    // color: Colors.red,
                    child: Center(child: Text("Profile Screen")),
                  ),
                ],
              )),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.white,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),

            onPressed: () {
              Get.to(EditArticleScreen());
            },
            //params
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar(
                backgroundColor: Colors.black,
                activeColor: AppColors.white,
                inactiveColor: Colors.white60,
                icons: [
                  Icons.home_outlined, // Replace with your home icon
                  Icons.task_rounded, // Replace with your search icon
                  Icons.bar_chart,
                  Icons.person, // Replace with your profile icon
                ],
                activeIndex: controller.bottomNavIndex.value,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.defaultEdge,
                onTap: (index) => controller.changeBottomNavIndex(index),
                //other params
              )),
          // bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar(
          //       icons: [
          //         Icons.pages_outlined, // Replace with your home icon
          //         Icons.search, // Replace with your search icon
          //         Icons.person,
          //         Icons.person, // Replace with your profile icon
          //       ],
          //       activeIndex: controller.bottomNavIndex.value,
          //       // leftCornerRadius: 32,
          //       // rightCornerRadius: 32,
          //       notchSmoothness: NotchSmoothness.defaultEdge,
          //       onTap: (index) => controller.changeBottomNavIndex(index),
          //       //other params
          //     )),
        );
      },
    );
  }
}
