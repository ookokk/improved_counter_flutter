import 'package:get_it/get_it.dart';
import 'package:improved_counter/counter_state.dart';
import 'list_view_state.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingleton<CounterState>(CounterState());
  getIt.registerSingleton<ListViewState>(ListViewState());
}
