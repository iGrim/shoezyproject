import 'package:flutter/material.dart';

class FavoritesNotifier extends ChangeNotifier {
  List<dynamic> _ids = [];

  List<dynamic> get ids => _ids;

  set ids(List<dynamic> newIds) {
    _ids = newIds;
    notifyListeners();
  }
}
