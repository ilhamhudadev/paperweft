// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StatusNetworkManager extends GetxController with WidgetsBindingObserver {
  //0 = No Internet
  //1 = connected to WIFI
  //2 = connected to Mobile Data
  int connectionType = 2;

  //Instance Connectivity
  final Connectivity connectivity = Connectivity();

  //listening to network
  late StreamSubscription streamSubscription;

  @override
  void onInit() {
    super.onInit;
    getConnectionType();
    streamSubscription = connectivity.onConnectivityChanged.listen(updateState);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (streamSubscription.isPaused) {
        getConnectionType();
        streamSubscription.resume();
      } else {
        getConnectionType();
      }
    }
  }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void> getConnectionType() async {
    ConnectivityResult connectivityResult = ConnectivityResult.none;
    try {
      connectivityResult = await (connectivity.checkConnectivity());
    } on PlatformException {}
    return updateState(connectivityResult);
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = 1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType = 2;
        update();
        break;
      case ConnectivityResult.none:
        connectionType = 0;
        try {
          InternetAddress.lookup('google.com').then((ipLookup) {
            if (ipLookup.isNotEmpty && ipLookup[0].rawAddress.isNotEmpty) {
              connectionType = 1;
              debugPrint("Connectifty Checking Connection Y $connectionType ");
            } else {
              connectionType = 0;
              debugPrint("Connectifty Checking Connection N $connectionType ");
            }
          });
        } on SocketException catch (_) {
          connectionType = 0;
        }
        update();
        break;
      default:
        // Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  @override
  void onClose() {
    streamSubscription.cancel();
  }
}
