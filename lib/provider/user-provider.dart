import 'package:flutter/material.dart';
import 'package:spoco_app/model/user.dart';

class UserProvider with ChangeNotifier {
  AppUser _user = AppUser.getAppUserEmptyObject();

  AppUser get user => _user;

  void updateUser(AppUser user) {
    _user = user;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return _user.toMap();
  }
}
