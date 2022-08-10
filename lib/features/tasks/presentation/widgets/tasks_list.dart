import 'package:flutter/material.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/task_widget.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  GlobalKey<SliverReorderableListState> listKey =
      GlobalKey<SliverReorderableListState>();

  late List<String> list;

  @override
  void initState() {
    super.initState();
    generateItems();
  }

  void generateItems() {
    list = List.generate(15, (index) => index.toString()).toList();
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final String item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverReorderableList(
      key: listKey,
      itemBuilder: (context, index) {
        return TaskWidget(
          key: Key('$index'),
          index: index,
          text: list[index],
        );
      },
      itemCount: 15,
      onReorder: onReorder,
      proxyDecorator: proxyDecoration,
    );
  }

  Widget proxyDecoration(Widget child, int index, Animation<double> animation) {
    return TaskWidget(
      key: child.key,
      index: index,
      text: list[index],
      ordering: true,
    );
  }
}
