import 'package:flutter/material.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/custom_radio.dart';

class SecondaryTaskWidget extends StatefulWidget {
  final int index;
  final String text;
  final Color? color;
  final bool? preview;

  const SecondaryTaskWidget({
    Key? key,
    required this.index,
    required this.text,
    this.color,
    this.preview = false,
  }) : super(key: key);

  @override
  State<SecondaryTaskWidget> createState() => _SecondaryTaskWidgetState();
}

class _SecondaryTaskWidgetState extends State<SecondaryTaskWidget>
    with TickerProviderStateMixin {
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
    );
  }

  Widget primaryTaskBody() {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 6, 24, 6),
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(color: Colors.transparent),
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        leadingBullet(),
        titleBuilder(widget.text),
      ],
    );
  }

  bool taskCompleted = false;

  Widget titleBuilder(String text) {
    return Text(
      text,
      style: TextStyle(
        color: taskCompleted ? Colors.white.withOpacity(0.8) : Colors.white,
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
        const SizedBox(
          width: 15,
        ),
        Text(
          widget.text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget dragHandleBuilder() {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => ScaleTransition(
        scale: animation,
        child: const CustomRadioButton(
          color: Colors.white,
        ),
      ),
    );
  }
}
