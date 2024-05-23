import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final void Function()? onPressed;

  @override
  final Size preferredSize;
  const CommonAppbar(
      {super.key, required this.title, this.onPressed, this.actions})
      : preferredSize = const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        ),
        actions: actions ??
            [
              IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ))
            ],
      ),
    );
  }
}
