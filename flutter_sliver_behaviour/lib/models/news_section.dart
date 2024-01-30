import 'package:flutter/material.dart';

class NewsSection extends ChangeNotifier {
  int number = 0;

  NewsSection() {
    print('Creating $runtimeType');
  }

  incrementNumber() {
    print('incrementing $runtimeType number');
    number++;
    notifyListeners();
  }

  refresh() {
    print('refreshing $runtimeType number');
    number = 0;
    notifyListeners();
  }
}
