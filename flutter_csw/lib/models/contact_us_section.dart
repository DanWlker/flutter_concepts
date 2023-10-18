import 'package:flutter/material.dart';

class ContactUsSection extends ChangeNotifier {
  int number = 0;

  ContactUsSection() {
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
