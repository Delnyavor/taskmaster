import 'package:flutter/material.dart';
import 'package:taskmaster/core/colors.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/custom_radio.dart';

class TaskWidget extends StatefulWidget {
  final int index;
  final String text;
  final bool ordering;
  final Color? color;

  const TaskWidget({
    Key? key,
    required this.index,
    required this.text,
    this.ordering = false,
    this.color,
  }) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> with TickerProviderStateMixin {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;

  late AnimationController controller;
  late Animation<double> animation;
  bool selecting = false;

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
    controller.forward().whenComplete(() {
      selecting = !selecting;
      controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onDoubleTap: toggleState,
        child: primaryTaskBody(),
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: [
        widget.ordering
            ? BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: -5,
                blurRadius: 8,
              )
            : const BoxShadow(
                color: Colors.transparent,
              ),
      ],
    );
  }

  Widget primaryTaskBody() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 38),
      padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
      decoration: decoration(),
      child: AnimatedCrossFade(
        firstChild: header(),
        secondChild: Column(children: [header(), secondChild()]),
        crossFadeState: crossFadeState,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleBuilder(widget.text),
        dragHandleBuilder(),
      ],
    );
  }

  bool taskCompleted = false;

  Widget titleBuilder(String text) {
    return Text(
      text,
      style: TextStyle(
        color: TMColors.textPrimary,
        decoration:
            taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  Widget leadingBullet() {
    return const CustomRadioButton(
      color: Colors.white,
      size: 15,
    );
  }

  Widget secondChild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.text,
          style: const TextStyle(
            color: TMColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget dragHandleBuilder() {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => ScaleTransition(
        scale: animation,
        child: !selecting
            ? ReorderableDragStartListener(
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
              )
            : const CustomRadioButton(
                color: Colors.white,
              ),
      ),
    );
  }
}
