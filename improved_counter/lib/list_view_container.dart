import 'package:flutter/material.dart';
import 'package:improved_counter/list_view_state.dart';
import 'package:improved_counter/posts.dart';
import 'package:improved_counter/service_locator.dart';

class ListViewContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = getIt.get<ListViewState>();
    return ValueListenableBuilder<List<Post>>(
        valueListenable: state.postsNotifier,
        builder: (context, postsValue, _) {
          return ListView(
            children: postsValue
                .map((postsNotifier) => ListTile(
                      title: Text(postsNotifier.title),
                      subtitle: Text(postsNotifier.body),
                      leading: CircleAvatar(
                        child: Text("${postsNotifier.id}"),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          state.postsNotifier.postRemoveTapped(postsNotifier);
                        },
                        icon: Icon(Icons.remove_circle_outline_outlined),
                      ),
                    ))
                .toList(),
          );
        });
  }
}
