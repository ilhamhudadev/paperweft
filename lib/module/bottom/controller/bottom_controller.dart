import 'package:get/get.dart';
import 'package:paperweft/module/bottom/data/repo/bottom_repo.dart';

class BottomController extends GetxController with BottomRepo {
  RxInt bottomNavIndex = 0.obs;

  void changeBottomNavIndex(int index) {
    bottomNavIndex.value = index;
    // Add your logic here for handling the bottom navigation item change
  }
}
