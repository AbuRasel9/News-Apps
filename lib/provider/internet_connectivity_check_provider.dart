import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectivityCheckProvider with ChangeNotifier{

  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  bool? _internetConnection;

  void setLoading({required bool loading}){
    _isLoading=loading;
    notifyListeners();

  }

  bool? get internetConnection=>_internetConnection;

  setInternetConnection(){
    InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
            _internetConnection = true;
            notifyListeners();
          break;
        case InternetStatus.disconnected:
          _internetConnection = false;
          notifyListeners();
          break;
        default:
          _internetConnection = false;
          notifyListeners();
          break;
      }
    });
  }


}