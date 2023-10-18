import 'package:flutter/material.dart';

class PromotionSection extends ChangeNotifier {
  int number = 0;

  PromotionSection() {
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
