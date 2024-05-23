import 'package:intl/intl.dart';

class HelperClass {
  // static List<String> getDateList() {
  //   // Get today's date
  //   // DateTime today = DateTime.now();
  //   // // Calculate tomorrow and the day after tomorrow
  //   // DateTime tomorrow = today.add(const Duration(days: 1));
  //   // DateTime dayAfterTomorrow = today.add(const Duration(days: 2));
  //   // Create the list of dates
  //   List<DateTime> dateTimeList = [today, tomorrow, dayAfterTomorrow];
  //   return dateTimeList;
  // }

  List<String> generateMorningSlots(DateTime date) {
    List<String> slots = [];
    DateTime current = DateTime(
        date.year,
        date.month,
        date.day,
        (date.day > DateTime.now().day
            ? 0
            : (date.hour >= 12 ? 12 : date.hour)),
        0);

    while (current.isBefore(DateTime(date.year, date.month, date.day, 12, 0))) {
      DateTime slotEnd = current.add(const Duration(hours: 1));
      slots.add(
          '${DateFormat('h:mm a').format(current)} - ${DateFormat('h:mm a').format(slotEnd)}');
      current = slotEnd;
    }
    return slots;
  }

  List<String> generateAfternoonSlots(DateTime date) {
    List<String> slots = [];
    DateTime current = DateTime(
        date.year,
        date.month,
        date.day,
        (date.day > DateTime.now().day
            ? 12
            : (date.hour <= 12 ? 12 : date.hour)),
        0);

    while (current.isBefore(DateTime(date.year, date.month, date.day, 24, 0))) {
      DateTime slotEnd = current.add(const Duration(hours: 1));
      slots.add(
          '${DateFormat('h:mm a').format(current)} - ${DateFormat('h:mm a').format(slotEnd)}');
      current = slotEnd;
    }
    return slots;
  }
}
