import 'package:flutter/material.dart';

class ArticleSection extends ChangeNotifier {
  int number = 0;

  ArticleSection() {
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
