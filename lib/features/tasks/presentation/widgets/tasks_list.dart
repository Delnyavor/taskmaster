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
    return TaskWidget(
      key: child.key,
      index: index,
      text: list[index],
      ordering: true,
    );
  }
}

class TaskWidget extends StatefulWidget {
  final int index;
  final String text;
  final bool ordering;

  const TaskWidget(
      {Key? key,
      required this.index,
      required this.text,
      this.ordering = false})
      : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> with TickerProviderStateMixin {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animation = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
  }

  void toggleState() {
    setState(() {
      if (crossFadeState == CrossFadeState.showFirst) {
        crossFadeState = CrossFadeState.showSecond;
      } else {
        crossFadeState = CrossFadeState.showFirst;
      }
    });
  }

  void animate() {
    controller.forward().whenComplete(() => controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onDoubleTap: toggleState,
        child: taskBody(),
      ),
    );
  }

  Widget taskBody() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 38),
        padding: const EdgeInsets.fromLTRB(15, 12, 0, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            widget.ordering
                ? BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: -5,
                    blurRadius: 8,
                    // offset: Offset(0, 2),
                  )
                : const BoxShadow(
                    color: Colors.transparent,
                  ),
          ],
        ),
        child: content());
  }

  Widget content() {
    return AnimatedCrossFade(
      firstChild: header(),
      secondChild: Column(children: [header(), header()]),
      crossFadeState: crossFadeState,
      duration: const Duration(milliseconds: 200),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.text),
        trailing(),
      ],
    );
  }

  Widget trailing() {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => ScaleTransition(
        scale: animation,
        child: ReorderableDragStartListener(
          child: IconButton(
            icon: const Icon(
              Icons.drag_handle_rounded,
              color: Color(0xFFD2DDFB),
              size: 32,
            ),
            onPressed: () {
              // print(widget.key);
              // print(widget.text);
            },
          ),
          index: widget.index,
        ),
      ),
    );
  }
}
