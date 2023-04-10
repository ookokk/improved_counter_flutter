import 'package:flutter/material.dart';

class CounterState {
  ValueNotifier<int> counter = ValueNotifier<int>(0);

  void incrementCounter() {
    counter.value++;
  }

  void decrementCounter() {
    counter.value--;
  }

  void resetCounter() {
    counter.value = 0;
  }
}
