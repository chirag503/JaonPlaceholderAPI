import 'package:flutter/material.dart';

class CommonOptionWidget extends StatelessWidget {
  final void Function()? onEdit;
  final void Function() onDelete;
  final bool wantEditButton;

  const CommonOptionWidget(
      {super.key,
      this.onEdit,
      required this.onDelete,
      this.wantEditButton = true});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) => [
        if (wantEditButton)
          PopupMenuItem(
            onTap: onEdit,
            height: 35,
            child: const Row(
              children: [
                Icon(
                  Icons.edit_note_outlined,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        PopupMenuItem(
          height: 35,
          onTap: onDelete,
          child: const Row(
            children: [
              Icon(
                Icons.delete_outline,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Delete",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
