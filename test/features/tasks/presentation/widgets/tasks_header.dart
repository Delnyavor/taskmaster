import 'package:flutter/material.dart';
import 'package:taskmaster/core/colors.dart';

class TasksHeader extends StatefulWidget {
  const TasksHeader({Key? key}) : super(key: key);

  @override
  State<TasksHeader> createState() => TasksHeaderState();
}

class TasksHeaderState extends State<TasksHeader> {
  bool selecting = false;

  void toggleSelect() {
    setState(() {
      selecting = !selecting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'TODO',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: TMColors.textMedium,
            ),
          ),
          selectionSwitch(),
        ],
      ),
    );
  }

  Widget selectionSwitch() {
    return selecting ? buttonRow() : select();
  }

  Widget select() {
    return InkWell(
      onTap: toggleSelect,
      child: const Text(
        'SELECT',
        style: TextStyle(
            fontSize: 12,
            height: 1.5,
            color: TMColors.teal,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buttonRow() {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text(
                'DELETE',
                style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: TMColors.rouge,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          InkWell(
            onTap: toggleSelect,
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'CANCEL',
                style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: TMColors.teal,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
