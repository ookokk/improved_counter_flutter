import 'package:flutter/material.dart';
import 'package:improved_counter/counter_state.dart';
import 'package:improved_counter/service_locator.dart';

class AppbarIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = getIt.get<CounterState>();

    return ValueListenableBuilder<int>(
        valueListenable: state.counter,
        builder: (context, counterValue, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              counterValue >= 0 ? Icons.mood : Icons.mood_bad,
              color: counterValue >= 0 ? Colors.green : Colors.red,
            ),
          );
        });
  }
}
