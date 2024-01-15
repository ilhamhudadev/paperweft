import 'package:get/get.dart';
import 'package:paperweft/module/house/data/repo/house_repo.dart';

class HouseController extends GetxController with HouseRepo {
  RxInt bottomNavIndex = 0.obs;

  void changeBottomNavIndex(int index) {
    bottomNavIndex.value = index;
    // Add your logic here for handling the bottom navigation item change
  }
}
