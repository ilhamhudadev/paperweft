import 'package:paperweft/core/network/status_network_manager.dart';
import 'package:get/get.dart';

class StatusNetworkBinding extends Bindings {
  // dependence injection attach our class.
  @override
  void dependencies() {
    Get.lazyPut<StatusNetworkManager>(() => StatusNetworkManager());
  }
}
