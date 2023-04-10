import 'package:flutter/material.dart';
import 'package:improved_counter/appbar_icon.dart';
import 'package:improved_counter/counter_state.dart';
import 'package:improved_counter/posts.dart';
import 'package:improved_counter/service_locator.dart';

import 'counter_text.dart';
import 'list_view_container.dart';
import 'list_view_state.dart';

void main() {
  initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Improved Counter',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: const MyHomePage(title: 'Improved Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Post postToAdd = Post(
    userId: 99,
    id: 4,
    title: "State",
    body: "Management",
  );

  @override
  void initState() {
    super.initState();

    final state = getIt.get<CounterState>();
    state.counter.addListener(() {
      if (state.counter.value % 10 == 0 && state.counter.value > 0) {
        _showMyDialog();
      }
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.bottomCenter,
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Restart'),
              onPressed: () {
                Navigator.of(context).pop();
                final state = getIt.get<CounterState>();
                state.resetCounter();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getIt.get<ListViewState>().postsNotifier.addPostTapped(postToAdd);
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add_circle,
          color: Colors.white,
          size: 40,
        ),
      ),
      appBar: AppBar(
        actions: [AppbarIcon()],
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            CounterText(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final state = getIt.get<CounterState>();
                    state.decrementCounter();
                  },
                  child: Icon(Icons.remove),
                ),
                ElevatedButton(
                    onPressed: () {
                      final state = getIt.get<CounterState>();
                      state.incrementCounter();
                    },
                    child: Icon(Icons.add)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  /*width: 50,
                  height: 50,*/
                  child: ElevatedButton(
                      onPressed: () {
                        final state = getIt.get<CounterState>();
                        state.resetCounter();
                      },
                      child: Icon(Icons.refresh)),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              /*width: MediaQuery.of(context).size.width * 0.6,*/
              child: ListViewContainer(),
            ),
          ],
        ),
      ),
    );
  }
}
