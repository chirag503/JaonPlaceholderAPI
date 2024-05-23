import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateDetailDialog extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController? controller2;
  final bool showSecondFeild;
  final bool showTitle;
  final void Function() onTap;
  final String feild1;
  final String? feild2;
  final String? title;
  final String buttonName;
  final bool enableButton;
  final void Function(String)? onChanged1;
  final void Function(String)? onChanged2;
  const UpdateDetailDialog(
      {super.key,
      required this.controller1,
      this.controller2,
      required this.onTap,
      this.showSecondFeild = true,
      required this.feild1,
      this.feild2,
      this.buttonName = "Update",
      this.showTitle = false,
      this.title,
      this.onChanged1,
      required this.enableButton,
      this.onChanged2});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      actionsPadding: const EdgeInsets.only(right: 14, bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            )),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showTitle) ...[
            Text(
              title ?? "",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 15,
            )
          ],
          DetailCard(
            title: feild1,
            controller: controller1,
            onChanged: onChanged1,
          ),
          if (showSecondFeild) ...[
            const SizedBox(
              height: 16,
            ),
            DetailCard(
              title: feild2 ?? "",
              controller: controller2,
              onChanged: onChanged2,
            ),
          ]
        ],
      ),
      actions: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(),
                color: enableButton ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(
              buttonName,
              style: TextStyle(
                  fontSize: 15,
                  color: enableButton ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }
}

class DetailCard extends StatelessWidget {
  final String title;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hintText;
  const DetailCard({
    super.key,
    required this.title,
    required this.controller,
    this.onChanged,
    this.maxLength,
    this.hintText,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: maxLength != null ? 65 : 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              inputFormatters: inputFormatters,
              onChanged: onChanged,
              controller: controller,
              maxLength: maxLength,
              maxLines: 5,
              minLines: 1,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
