import 'package:flutter/material.dart';

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
    print("oldindex: $oldIndex newindex: $newIndex");
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
        return TaskWidget(key: Key('$index'), index: index, text: list[index]);
      },
      itemCount: 15,
      onReorder: onReorder,
      proxyDecorator: proxyDecoration,
    );
  }

  Widget proxyDecoration(Widget child, int index, Animation<double> animation) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: -2)
        ],
      ),
      child: child,
    );
  }
}

class TaskWidget extends StatefulWidget {
  final int index;
  final String text;

  const TaskWidget({Key? key, required this.index, required this.text})
      : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 38),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 12, 0, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.text),
              trailing(),
            ],
          ),
        ),
      ),
    );
  }

  Widget trailing() {
    return ReorderableDragStartListener(
      child: IconButton(
        icon: const Icon(
          Icons.drag_handle_rounded,
          color: Color(0xFFD2DDFB),
          size: 32,
        ),
        onPressed: () {
          print(widget.key);
          print(widget.index);
        },
      ),
      index: widget.index,
    );
  }
}
