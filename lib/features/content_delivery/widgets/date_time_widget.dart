
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatelessWidget {
  final String title;
  final int? selectedIndex;
  final DateTime? date;
  final void Function(int) onTap;
  final void Function(String?)? onMorningSlot;
  final void Function(String?)? onAfternoonSlot;
  const DateTimeWidget(
      {super.key,
      required this.title,
      this.selectedIndex,
      required this.onTap,
      this.onMorningSlot,
      this.onAfternoonSlot,
      required this.date});

  @override
  Widget build(BuildContext context) {
    final dateList = ["Today", "Tomorrow", "Select Date"];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            dateList.length,
            (index) => InkWell(
              onTap: () {
                onTap(index);
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 3.5,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: selectedIndex == index
                        ? const Color(0xff5f94ef)
                        : Colors.white),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(dateList[index],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.grey)),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                          DateFormat("dd MMM").format(
                              (selectedIndex == 2 && index == 2)
                                  ? (date ??
                                      DateTime.now().add(Duration(days: index)))
                                  : DateTime.now().add(Duration(days: index))),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.grey))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
