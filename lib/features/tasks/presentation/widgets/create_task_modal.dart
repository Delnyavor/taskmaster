import 'package:flutter/material.dart';
import 'package:taskmaster/core/colors.dart';
import 'package:taskmaster/features/tasks/presentation/widgets/custom_timer_picker.dart';

void openCreateTaskModal(BuildContext context) {
  Scaffold.of(context).showBottomSheet(
    // context: context,
    (context) => CreateTaskWidget(),
    backgroundColor: TMColors.teal,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
    ),
  );
}

class CreateTaskWidget extends StatelessWidget {
  CreateTaskWidget({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final labelStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    height: 1.5,
    color: Colors.black.withOpacity(0.27),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        inputForm(context),
        controls(),
      ],
    );
  }

  Widget inputForm(context) {
    return Container(
      padding: const EdgeInsets.all(44),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          label(),
          titleField(),
          addNoteButton(),
          durationDisplay(context),
        ],
      ),
    );
  }

  Widget label() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 11.0),
          child: Text(
            'create task'.toUpperCase(),
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                height: 1.5,
                color: TMColors.teal),
          ),
        ),
      ],
    );
  }

  Widget titleField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Title',
        hintStyle: labelStyle,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        fillColor: const Color(0xfff2f2f2).withOpacity(0.5),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xfff2f2f2).withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: TMColors.teal,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget addNoteButton() {
    return TextButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(
            Icons.add,
            color: TMColors.textLight,
          ),
          Text(
            'Add note'.toUpperCase(),
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              height: 1.5,
              color: TMColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget controls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 13),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Delete'.toUpperCase(),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Add task'.toUpperCase(),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  height: 1.5,
                  color: TMColors.teal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget durationDisplay(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (context) => timerPicker());
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: TMColors.canvasWhite,
          border: Border.all(color: TMColors.textLight),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'Duration',
              style: labelStyle.copyWith(fontSize: 11),
            ),
            durationText(),
          ],
        ),
      ),
    );
  }

  Widget durationText() {
    var duration = const Duration(seconds: 210);
    return Text(duration.inMinutes.toString());
  }

  Widget timerPicker() {
    return const CustomTimerPicker();
    // return CupertinoTimerPicker(
    //   mode: CupertinoTimerPickerMode.ms,
    //   onTimerDurationChanged: (Duration duration) {},
    //   backgroundColor: Colors.white,
    // );
  }
}
