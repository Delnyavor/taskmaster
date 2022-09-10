import 'package:flutter/material.dart';
import 'package:taskmaster/core/colors.dart';

class TaskInputForm extends StatefulWidget {
  const TaskInputForm({Key? key}) : super(key: key);

  @override
  State<TaskInputForm> createState() => _TaskInputFormState();
}

class _TaskInputFormState extends State<TaskInputForm>
    with TickerProviderStateMixin {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  bool open = false;
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animation = Tween(begin: 25.0, end: 19.0).animate(controller);
  }

  void resetOpenState() {
    setState(() {
      open = !open;
    });
    if (open) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return inputColumn();
  }

  BoxDecoration backgroundDecoration() {
    return BoxDecoration(
      color: TMColors.canvasWhite,
      borderRadius: BorderRadius.circular(25),
    );
  }

  Widget inputColumn() {
    return Column(
      children: [
        DecoratedBox(
          decoration: backgroundDecoration(),
          child: Column(
            children: [
              titleInput(),
              crossfade(),
            ],
          ),
        ),
        buttonCrossFade(),
      ],
    );
  }

  Widget crossfade() {
    return AnimatedCrossFade(
      firstChild: firstChild(),
      secondChild: secondChild(),
      crossFadeState:
          open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
      firstCurve: Curves.easeOut,
      secondCurve: Curves.easeInCubic,
    );
  }

  Widget firstChild() {
    return SizedBox.fromSize(size: const Size.fromHeight(0));
  }

  Widget secondChild() {
    return Container(
      decoration: backgroundDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          separator(),
          noteInput(),
        ],
      ),
    );
  }

  Widget separator() {
    return const Divider(
      height: 0.1,
      thickness: 0,
      color: TMColors.textMedium,
      indent: 25,
      endIndent: 25,
    );
  }

  Widget titleInput() {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => TextField(
        controller: titleController,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: 'Title',
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            height: 0,
            color: Colors.black.withOpacity(0.3),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 25, vertical: animation.value),
          fillColor: TMColors.canvasWhite,
          filled: false,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget noteInput() {
    return TextField(
      controller: noteController,
      maxLines: 3,
      style: const TextStyle(fontSize: 11),
      decoration: InputDecoration(
        hintText: 'Enter note...',
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
          height: 0,
          color: Colors.black.withOpacity(0.3),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        fillColor: const Color(0xfff2f2f2).withOpacity(0.5),
        filled: false,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }

  Widget buttonCrossFade() {
    return AnimatedCrossFade(
      firstChild: addNoteButton('Add note'),
      secondChild: addNoteButton('remove text'),
      crossFadeState:
          open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 10),
    );
  }

  Widget addNoteButton(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 15),
      child: TextButton(
        style: TextButton.styleFrom(primary: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.add,
              color: TMColors.textLight,
            ),
            noteButtonText(text)
          ],
        ),
        onPressed: resetOpenState,
      ),
    );
  }

  Widget noteButtonText(String text) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: TMColors.textLight,
      ),
    );
  }
}
