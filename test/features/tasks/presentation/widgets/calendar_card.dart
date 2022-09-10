import 'package:flutter/material.dart';
import 'package:taskmaster/core/colors.dart';

class CalendarRow extends StatefulWidget {
  const CalendarRow({Key? key}) : super(key: key);

  @override
  State<CalendarRow> createState() => _CalendarRowState();
}

class _CalendarRowState extends State<CalendarRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        calendarCard(),
        const SizedBox(width: 8),
        calendarCard(selected: true),
        const SizedBox(width: 8),
        calendarCard(),
        const SizedBox(width: 8),
        calendarCard(),
      ],
    );
  }

  Widget calendarCard({bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: cardDecoration(selected),
      child: cardContent(selected),
    );
  }

  Widget cardContent(bool selected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('13',
            style: TextStyle(
                fontSize: 20,
                color: selected ? Colors.white : TMColors.textMedium)),
        const SizedBox(height: 3),
        Text("APR\n|\nTUE",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: selected ? Colors.white : TMColors.textMedium)),
      ],
    );
  }

  Decoration cardDecoration(bool selected) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: selected
          ? TMColors.teal.withOpacity(0.68)
          : TMColors.lavender.withOpacity(0.58),
      border: Border.fromBorderSide(
        BorderSide(
            color: selected
                ? TMColors.teal.withOpacity(0)
                : TMColors.violet.withOpacity(0.27),
            width: 2.6),
      ),
    );
  }
}
