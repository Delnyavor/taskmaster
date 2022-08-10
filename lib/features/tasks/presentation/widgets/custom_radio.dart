import 'package:flutter/material.dart';
import 'package:taskmaster/core/colors.dart';

class CustomRadioButton extends StatefulWidget {
  final Color? color;
  final Function? onTap;
  final double? size;
  const CustomRadioButton(
      {Key? key, required this.color, this.onTap, this.size})
      : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  bool radioSelected = false;

  void handleTap() {
    if (widget.onTap == null) {
      setState(() {
        radioSelected = !radioSelected;
      });
      widget.onTap;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: null,
      onTap: handleTap,
      child: Container(
        color: Colors.transparent,
        height: 48,
        width: 48,
        child: Center(
          child: Container(
            height: widget.size ?? 20,
            width: widget.size ?? 20,
            decoration:
                radioSelected ? selectedDecoration() : unSelectedDecoration(),
          ),
        ),
      ),
    );
  }

  BoxDecoration selectedDecoration() {
    return BoxDecoration(
      color: widget.color ?? TMColors.violet.withOpacity(0.95),
      borderRadius: BorderRadius.circular(100),
    );
  }

  BoxDecoration unSelectedDecoration() {
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        color: widget.color ?? Colors.white.withOpacity(0.95),
        width: 1.5,
      ),
    );
  }
}
