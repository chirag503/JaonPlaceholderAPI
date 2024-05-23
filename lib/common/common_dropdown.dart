import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CommonDropDown extends StatelessWidget {
  const CommonDropDown({
    required this.labelTitle,
    this.hintText,
    required this.onChanged,
    required this.selectedValue,
    required this.listofitems,
    super.key,
  });

  final String? labelTitle;
  final String? hintText;
  final void Function(String?)? onChanged;
  final String? selectedValue;
  final List<dynamic>? listofitems;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width / 2 - 24,
      child: Theme(
        data: ThemeData(
            useMaterial3: false,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelTitle!,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 5,
            ),
            // drop down
            DropdownButtonFormField2(
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 150,
                elevation: 1,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.white,
                ),
              ),
              isExpanded: true,
              isDense: true,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: const InputDecoration(
                isDense: true,
                filled: true,
                contentPadding: EdgeInsets.zero,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              hint: const Text(
                "Select Time",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
              iconStyleData:
                  const IconStyleData(icon: Icon(Icons.keyboard_arrow_down)),
              items: (listofitems ?? []).map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: SizedBox(
                    child: Text(
                      item,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                );
              }).toList(),
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.zero,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: 40,
              ),
              value: selectedValue,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
