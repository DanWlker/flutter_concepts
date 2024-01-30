import 'package:flutter/material.dart';

class VideoSection extends ChangeNotifier {
  int number = 0;

  VideoSection() {
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
